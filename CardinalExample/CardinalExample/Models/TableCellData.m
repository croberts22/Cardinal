//
//  TableCellData.m
//  CardinalExample
//
//  Created by Corey Roberts on 12/20/15.
//  Copyright © 2015 Corey Roberts. All rights reserved.
//

#import "TableCellData.h"

@interface TableCellData()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cellDescription;
@property (nonatomic, strong) void (^block)(void);

@end

@implementation TableCellData

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)description block:(void (^)(void))block {
    self = [super init];
    if (self) {
        _title = [title copy];
        _cellDescription = [description copy];
        _block = block;
    }
    
    return self;
}

@end
