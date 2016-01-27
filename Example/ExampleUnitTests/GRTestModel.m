//
//  GRTestModel.m
//  Example
//
//  Created by Bell on 15/11/3.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "GRTestModel.h"
#import <objc/runtime.h>

@implementation GRTestModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _key1 = @"key1";
    }
    return self;
}

#pragma mark - Property

+ (BOOL)gr_useNullProperty
{
    return YES;
}

+ (NSArray<NSString *> *)gr_ignoredPropertyNames
{
    return @[@"key0"];
}

+ (NSDictionary<NSString*, NSString*>*)gr_replacedPropertyNames
{
    return @{@"key4":@"replace_key4"};
}

+ (NSDictionary<NSString *, Class > *)gr_classInArray
{
    return @{@"key2":[GRTestModel class]};;
}

@end
