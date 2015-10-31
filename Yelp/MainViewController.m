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
#import "Filter.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *businesses;
@property (nonatomic, strong) NSMutableArray *filters;

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
    
    self.filters = [YelpFilters initialize];

    // Search bar
    self.searchBar = [[SearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.text = @"Restaurant";
    
    // Navigation
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.69 green:0.02 blue:0.02 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter"]
                                                               landscapeImagePhone:nil
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onFilterButton)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    
    
    
    
    

    // Results
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil]
         forCellReuseIdentifier:@"businessCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0;
}


#pragma - User actions

- (void)onFilterButton {
    FiltersViewController *vc = [[FiltersViewController alloc] init];
    vc.delegate = self;
    
    for (Filter *filter in self.filters) {
        [vc.filters addObject:[filter copy]];
    }
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
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
    [searchBar resignFirstResponder];
    [self search];
}


#pragma - FiltersViewControllerDelegate

- (void)filtersViewController:(FiltersViewController *)filterViewController didChangeFilters:(NSMutableArray *)filters {
    self.filters = filters;
    [self search];
}


#pragma - Private

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

- (NSMutableArray *)filters {
    if (!_filters) {
        _filters = [NSMutableArray array];
    }
    return _filters;
}

@end