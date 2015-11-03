//
//  GRBaseTestModel.m
//  Example
//
//  Created by Bell on 15/11/3.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "GRBaseTestModel.h"

@implementation GRBaseTestModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _base0 = @"base0";
        _base1 = @"base1";
    }
    return self;
}

+ (NSArray*)gr_ignoredPropertyNames
{
    return @[@"base0"];
}

@end
