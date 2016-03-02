//
//  GRBaseTestModel.m
//  Example
//
//  Created by Bell on 15/11/3.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "GRBaseTestModel.h"
#import "NSObject+GreedJSON.h"

@implementation GRBaseTestModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _base0 = @"base0";
        _base1 = @"base1";
    }
    return self;
}

+ (NSArray<NSString *> *)gr_ignoredPropertyNames {
    NSMutableArray *array = [[self gr_propertyNames] mutableCopy];
    [array removeObject:@"base1"];
    return array;
}

@end
