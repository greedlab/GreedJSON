//
//  GRTestModel.m
//  Example
//
//  Created by Bell on 15/11/3.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "GRTestModel.h"

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

+ (NSArray*)gr_ignoredPropertyNames
{
    return @[@"key0"];
}

+ (NSArray*)gr_allowedPropertyNames
{
    return @[@"key0",@"key1",@"key2",@"key3",@"key4",@"key5",@"key6",@"key7"];
}

+ (NSDictionary*)gr_replacedPropertyNames
{
    return @{@"key4":@"replace_key4"};
}

+ (NSDictionary *)gr_classInArray
{
    return @{@"key2":[GRTestModel class]};;
}

@end
