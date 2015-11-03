//
//  NSObject+GreedJSON.m
//  Pods
//
//  Created by Bell on 15/11/3.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "NSObject+GreedJSON.h"
#import <objc/runtime.h>
#import "GRJSONHelper.h"

@implementation NSObject (GreedJSON)

#pragma mark - property getter

- (NSArray*)propertyNames
{
    return [GRJSONHelper propertyNames:[self class]];
}

#pragma mark - Property init

+ (BOOL)gr_useNullProperty
{
    return NO;
}

+ (NSArray*)gr_ignoredPropertyNames
{
    NSArray *array = nil;
    Class superClass = class_getSuperclass([self class]);
    if (superClass && superClass != [NSObject class]) {
        array = [superClass gr_ignoredPropertyNames];
    }
    return array;
}

+ (NSArray*)gr_allowedPropertyNames
{
    NSArray *array = nil;
    Class superClass = class_getSuperclass([self class]);
    if (superClass && superClass != [NSObject class]) {
        array = [superClass gr_allowedPropertyNames];
    }
    return array;
}

+ (NSDictionary*)gr_replacedPropertyNames
{
    NSDictionary *dictionary = nil;
    Class superClass = class_getSuperclass([self class]);
    if (superClass && superClass != [NSObject class]) {
        dictionary = [superClass gr_replacedPropertyNames];
    }
    return dictionary;
}

+ (NSDictionary *)gr_classInArray
{
    NSDictionary *dictionary = nil;
    Class superClass = class_getSuperclass([self class]);
    if (superClass && superClass != [NSObject class]) {
        dictionary = [superClass gr_classInArray];
    }
    return dictionary;
}

#pragma mark - Foundation

- (BOOL)gr_isFromFoundation
{
    return [GRJSONHelper gr_isClassFromFoundation:[self class]];
}

#pragma mark - parse

- (instancetype)gr_setDictionary:(NSDictionary*)dictionary
{
    Class aClass = [self class];
    NSArray *allowedPropertyNames = [aClass gr_allowedPropertyNames];
    NSArray *ignoredPropertyNames = [aClass gr_ignoredPropertyNames];
    NSDictionary *replacedPropertyNames = [aClass gr_replacedPropertyNames];
    
    NSArray *propertyNames = [GRJSONHelper propertyNames:aClass];
    [propertyNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = (NSString *)obj;
        if (allowedPropertyNames && ![allowedPropertyNames containsObject:key]) {
            return ;
        }
        if (ignoredPropertyNames && [ignoredPropertyNames containsObject:key]) {
            return;
        }
        if ([GRJSONHelper isPropertyReadOnly:aClass propertyName:key]) {
            return;
        }
        
        NSString *dictKey= nil;
        dictKey = [replacedPropertyNames objectForKey:key];
        if (!dictKey) {
            dictKey = key;
        }
        
        id value = [dictionary valueForKey:dictKey];
        if (value == [NSNull null] || value == nil) {
            if ([aClass gr_useNullProperty]) {
                [self setValue:[NSNull null] forKey:key];
            }
            return;
        }
        
        if ([value isKindOfClass:[NSDictionary class]]) { // handle dictionary
            Class klass = [GRJSONHelper propertyClassForPropertyName:key ofClass:aClass];
            if (klass == [NSDictionary class]) {
                [self setValue:value forKey:key];
            } else {
                [self setValue:[[klass class] gr_objectFromDictionary:value] forKey:key];
            }
        } else if ([value isKindOfClass:[NSArray class]]) { // handle array
            NSMutableArray *childObjects = [NSMutableArray arrayWithCapacity:[(NSArray*)value count]];
            [value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([[obj class] isSubclassOfClass:[NSDictionary class]]) {
                    Class arrayItemClass = [[aClass gr_classInArray] objectForKey:key];
                    if (!arrayItemClass || arrayItemClass == [NSDictionary class]) {
                        [childObjects addObject:obj];
                    } else {
                        NSObject *child = [[arrayItemClass class] gr_objectFromDictionary:obj];
                        [childObjects addObject:child];
                    }
                } else {
                    [childObjects addObject:obj];
                }
            }];
            
            [self setValue:childObjects forKey:key];
        } else {
            // handle all others
            [self setValue:value forKey:key];
        }
    }];
    return self;
}

+ (instancetype)gr_objectFromDictionary:(NSDictionary*)dictionary
{
    return [[[self alloc] init] gr_setDictionary:dictionary];
}

- (__kindof NSObject *)gr_dictionary
{
    if ([self gr_isFromFoundation]) {
        return self;
    }
    
    Class aClass = [self class];
    NSArray *allowedPropertyNames = [aClass gr_allowedPropertyNames];
    NSArray *ignoredPropertyNames = [aClass gr_ignoredPropertyNames];
    NSDictionary *replacedPropertyNames = [aClass gr_replacedPropertyNames];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *propertyNames = [GRJSONHelper propertyNames:[self class]];
    
    [propertyNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = (NSString*)obj;
        if (allowedPropertyNames && ![allowedPropertyNames containsObject:obj]) {
            return ;
        }
        if (ignoredPropertyNames && [ignoredPropertyNames containsObject:obj]) {
            return;
        }
        id value = [self valueForKey:key];
        if (value) {
            NSString *dictKey= nil;
            dictKey = [replacedPropertyNames objectForKey:key];
            if (!dictKey) {
                dictKey = key;
            }
            if ([value isKindOfClass:[NSArray class]]) {
                NSUInteger count = ((NSArray*)value).count;
                if (count) {
                    NSMutableArray *internalItems = [[NSMutableArray alloc] initWithCapacity:count];
                    [value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [internalItems addObject:[obj gr_dictionary]];
                    }];
                    [dic setObject:internalItems forKey:dictKey];
                }
            } else if ([value gr_isFromFoundation]) {
                [dic setObject:value forKey:dictKey];
            } else {
                [dic setObject:[value gr_dictionary] forKey:dictKey];
            }
        }
    }];
    
    return dic;
}

@end
