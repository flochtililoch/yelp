//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "NavigationViewController.h"
#import "FiltersViewController.h"
#import "MBProgressHUD.h"
#import "YelpBusiness.h"
#import "BusinessCell.h"
#import "SearchBar.h"
#import "YelpFilters.h"
#import "Filter.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate, FiltersViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) SearchBar *searchBar;
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
    [self searchFromOffset:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma - UI

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[SearchBar alloc] init];
    }
    return _searchBar;
}

- (void)initUI {
    
    self.filters = [YelpFilters initialize];

    // Search bar
    self.searchBar.delegate = self;
    self.searchBar.text = @"Restaurant";
    
    // Navigation
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter"]
                                                               landscapeImagePhone:nil
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onFilterButton)];

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
    
    NavigationViewController *nvc = [[NavigationViewController alloc] initWithRootViewController:vc];
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


#pragma - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}


#pragma - UITableViewDelegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    return nil;
}


#pragma - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self searchFromOffset:nil];
}


#pragma - FiltersViewControllerDelegate

- (void)filtersViewController:(FiltersViewController *)filterViewController didChangeFilters:(NSMutableArray *)filters {
    self.filters = filters;
    [self searchFromOffset:nil];
}


#pragma - Private

- (void)searchFromOffset:(NSUInteger *)offset {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [YelpBusiness searchWithTerm:self.searchBar.text
                             filters:self.filters
                              offset:offset
                          completion:^(NSArray *businesses, NSError *error) {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  self.businesses = businesses;
                                  [self.tableView reloadData];
                                  [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
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