//
//  FiltersViewController.m
//  Yelp
//
//  Created by Florent Bonomo on 10/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "FiltersViewController.h"
#import "SwitchCell.h"
#import "CheckCell.h"
#import "YelpFilters.h"
#import "Filter.h"
#import "FilterOption.h"

@interface FiltersViewController () <UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate, CheckCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self initUI];
}


#pragma - UI

- (void)initUI {
    
    // Navigation
    self.navigationItem.title = @"Filters";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButton)];
    
    
    // Filters
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil]
         forCellReuseIdentifier:@"switchCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckCell" bundle:nil]
         forCellReuseIdentifier:@"checkCell"];
}


#pragma - User actions

- (void)onCancelButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onApplyButton {
    [self.delegate filtersViewController:self didChangeFilters:self.filters];
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.filters.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Filter *filter = [self.filters objectAtIndex:section];
    return filter.options.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Filter *filter = [self.filters objectAtIndex:section];
    return filter.title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *sectionsCellsIds = @[@"switchCell", @"checkCell", @"checkCell", @"switchCell"];
    
    Filter *filter = [self.filters objectAtIndex:indexPath.section];
    FilterOption *filterOption = filter.options[indexPath.row];
    
    SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionsCellsIds[indexPath.section]];
    cell.delegate = self;
    cell.titleLabel.text = filterOption.name;
    cell.on = filterOption.selected;

    return cell;
}


#pragma - SwitchCellDelegate

- (void)switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    Filter *filter = [self.filters objectAtIndex:indexPath.section];
    [filter toggleOptionAtIndex:indexPath.row];
}


#pragma - CheckCellDelegate

- (void)cellWasTapped:(CheckCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

    Filter *filter = [self.filters objectAtIndex:indexPath.section];
    
    // Prepare reference to previously selected and newly selected rows
    NSUInteger currentlySelectedRowIndex = [filter.options indexOfObject:[[filter selectedOptions] firstObject]];
    NSArray *rowsToReload = @[[NSIndexPath indexPathForRow:currentlySelectedRowIndex inSection:indexPath.section], indexPath];
    
    // Set model
    [filter resetSelectionWithOptionAtIndex:indexPath.row];
    
    // Refresh changed rows
    [self.tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
}


#pragma - Private

- (NSMutableArray *)filters {
    if (!_filters) {
        _filters = [NSMutableArray array];
    }
    return _filters;
}

@end
