//
//  FiltersViewController.m
//  Yelp
//
//  Created by Florent Bonomo on 10/28/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "FiltersViewController.h"
#import "SwitchCell.h"
#import "YelpFilters.h"

@interface FiltersViewController () <UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate>

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(onApplyButton)];
    
    
    // Filters
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil]
         forCellReuseIdentifier:@"switchCell"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.filters class] categories].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
    
    NSDictionary *category = [[self.filters class] categories][indexPath.row];
    
    cell.titleLabel.text = category[@"name"];
    cell.on = [self.filters.selectedCategories containsObject:category];
    cell.delegate = self;
    
    return cell;
}


#pragma - SwitchCellDelegate

- (void)switchCell:(SwitchCell *)switchCell didUpdateValue:(BOOL)value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:switchCell];
    
    if (value) {
        [self.filters.selectedCategories addObject:[[self.filters class] categories][indexPath.row]];
    } else {
        [self.filters.selectedCategories removeObject:[[self.filters class] categories][indexPath.row]];
    }
}

@end
