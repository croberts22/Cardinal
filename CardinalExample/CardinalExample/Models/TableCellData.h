//
//  TableCellData.h
//  CardinalExample
//
//  Created by Corey Roberts on 12/20/15.
//  Copyright © 2015 Corey Roberts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableCellData : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *cellDescription;
@property (nonatomic, readonly) void (^block)(void);

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)description block:(void(^)(void))block;

@end
