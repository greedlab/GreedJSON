//
//  NSObject+GreedJSON.m
//  Pods
//
//  Created by Bell on 15/11/3.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "NSObject+GreedJSON.h"
#import "GRJSONHelper.h"

static NSSet *__grFoundationClasses;

@implementation NSObject (GreedJSON)

#pragma mark - Property

+ (BOOL)gr_useNullProperty
{
    return NO;
}

+ (NSArray*)gr_ignoredPropertyNames
{
    return nil;
}

+ (NSArray*)gr_allowedPropertyNames
{
    return nil;
}

+ (NSDictionary*)gr_replacedPropertyNames
{
    return nil;
}

+ (NSDictionary *)gr_classInArray
{
    return nil;
}

#pragma mark - Foundation

+ (NSSet *)gr_foundationClasses
{
    if (!__grFoundationClasses) {
        __grFoundationClasses = [NSSet setWithObjects:
                                 [NSURL class],
                                 [NSDate class],
                                 [NSValue class],
                                 [NSData class],
                                 [NSError class],
                                 [NSArray class],
                                 [NSDictionary class],
                                 [NSString class],
                                 [NSAttributedString class], nil];
    }
    return __grFoundationClasses;
}

+ (BOOL)gr_isFromFoundationWithClass:(Class)class
{
    __block BOOL result = NO;
    [[[NSObject class] gr_foundationClasses] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
        if ([class isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

- (BOOL)gr_isFromFoundation
{
    return [[self class] gr_isFromFoundationWithClass:[self class]];
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
