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
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) BOOL isSearching;

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

    CGFloat actualPosition = self.tableView.contentOffset.y;
    CGFloat contentHeight = self.tableView.contentSize.height - self.tableView.frame.size.height;
    if (actualPosition >= contentHeight) {
        [self searchWithOffset:self.businesses.count];
    }
    
}


#pragma - UITableViewDelegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    return nil;
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
    self.businesses = [NSArray array];
    [self searchWithOffset:0];
}

- (void)searchWithOffset:(NSInteger)offset {
    if (offset == 0 || (offset < self.totalCount && !self.isSearching)) {
        self.isSearching = YES;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [YelpBusiness searchWithTerm:self.searchBar.text
                                 filters:self.filters
                                  offset:offset
                              completion:^(NSArray *businesses, NSInteger totalCount, NSError *error) {
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      self.businesses = [self.businesses arrayByAddingObjectsFromArray:businesses];
                                      self.totalCount = totalCount;
                                      [self.tableView reloadData];
                                      if (!offset) {
                                          [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                                      }
                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                      self.isSearching = NO;
                                  });
                              }];
        });
    }
}

- (NSMutableArray *)filters {
    if (!_filters) {
        _filters = [NSMutableArray array];
    }
    return _filters;
}

- (NSArray *)businesses {
    if (!_businesses) {
        _businesses = [NSArray array];
    }
    return _businesses;
}

@end