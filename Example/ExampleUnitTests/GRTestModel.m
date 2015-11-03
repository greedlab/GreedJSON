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

+ (NSArray*)gr_ignoredPropertyNames
{
    Class superClass = class_getSuperclass([self class]);
    NSArray *array = [superClass gr_ignoredPropertyNames];
    return [array arrayByAddingObjectsFromArray:@[@"key0"]];
}

+ (NSArray*)gr_allowedPropertyNames
{
    Class superClass = class_getSuperclass([self class]);
    return [superClass gr_allowedPropertyNames];
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
