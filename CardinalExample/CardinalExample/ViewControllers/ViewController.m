//
//  ViewController.m
//  CardinalExample
//
//  Created by Corey Roberts.
//  Copyright © 2015 Corey Roberts. All rights reserved.
//

#import "ViewController.h"
#import "TableCellData.h"

#import "CardinalExample-Swift.h"

@interface ViewController()
@property (nonatomic, copy) NSArray *tableData;
@end

@implementation ViewController

#pragma mark - UITableViewCell Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableData = @[
                       [[TableCellData alloc] initWithTitle:@"Debug"
                                                description:@"Logs a message with the debug format."
                                                      block:^{ LogDebug(@"Logging a debug message."); }],
                       [[TableCellData alloc] initWithTitle:@"Debug with Category"
                                                description:@"Logs a debug message with a category."
                                                      block:^{ LogDebugCategory(CardinalCategoryUserInterface, @"Use categories (such as CardinalCategoryUserInterface) to highlight events in your logger."); }],
                       
                       [[TableCellData alloc] initWithTitle:@"Info"
                                                description:@"Logs a message with the info format."
                                                      block:^{ LogInfo(@"Logging an info message."); }],
                       [[TableCellData alloc] initWithTitle:@"Info with Category"
                                                description:@"Logs an info message with a category."
                                                      block:^{ LogInfoCategory(CardinalCategoryUserInterface, @"Use categories (such as CardinalCategoryUserInterface) to highlight events in your logger."); }],
                       
                       [[TableCellData alloc] initWithTitle:@"Warning"
                                                description:@"Logs a message with the warning format."
                                                      block:^{ LogWarning(@"Logging a warning message."); }],
                       [[TableCellData alloc] initWithTitle:@"Warning with Category"
                                                description:@"Logs a warning message with a category."
                                                      block:^{ LogWarningCategory(CardinalCategoryUserInterface, @"Use categories (such as CardinalCategoryUserInterface) to highlight events in your logger."); }],
                       
                       [[TableCellData alloc] initWithTitle:@"Error"
                                                description:@"Logs a message with the error format."
                                                      block:^{ LogError(@"Logging an error message."); }],
                       [[TableCellData alloc] initWithTitle:@"Error with Category"
                                                description:@"Logs an error message with a category."
                                                      block:^{ LogErrorCategory(CardinalCategoryUserInterface, @"Use categories (such as CardinalCategoryUserInterface) to highlight events in your logger."); }],
                       
                       
                       
                       ];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    TableCellData *cellData = self.tableData[indexPath.row];
    
    cell.textLabel.text = cellData.title;
    cell.detailTextLabel.text = cellData.cellDescription;
    
    return cell;
}


#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCellData *cellData = self.tableData[indexPath.row];
    cellData.block();
}

@end
