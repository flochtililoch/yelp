//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "FiltersViewController.h"
#import "MBProgressHUD.h"
#import "YelpBusiness.h"
#import "BusinessCell.h"
#import "SearchBar.h"
#import "YelpFilters.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *businesses;
@property (nonatomic, strong) YelpFilters *filters;

@end

@implementation MainViewController


#pragma - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self initUI];
    [self search];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma - UI

- (void)initUI {
    
    [self initFilters];

    // Search bar
    self.searchBar = [[SearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.text = @"Restaurant";
    
    // Navigation
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onFilterButton)];
    

    // Results
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil]
         forCellReuseIdentifier:@"businessCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
}


#pragma - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"businessCell"];
    cell.business = self.businesses[indexPath.row];
    return cell;
}


#pragma - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self search];
}


#pragma - FiltersViewControllerDelegate

- (void)filtersViewController:(FiltersViewController *)filterViewController didChangeFilters:(YelpFilters *)filters {
    self.filters = filters;
    [self search];
}


#pragma - Private

- (void)initFilters {
    self.filters = [[YelpFilters alloc] init];
}

- (void)search {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [YelpBusiness searchWithTerm:self.searchBar.text
                             filters:self.filters
                          completion:^(NSArray *businesses, NSError *error) {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  self.businesses = businesses;
                                  [self.tableView reloadData];
                                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                              });
                          }];
    });
}

- (void)onFilterButton {
    FiltersViewController *vc = [[FiltersViewController alloc] init];
    vc.delegate = self;
    vc.filters = [self.filters copy];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

@end