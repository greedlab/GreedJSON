//
//  NSString+GreedJSON.m
//  GreedJSON
//
//  Created by Bell on 15/5/19.
//  Copyright (c) 2015年 GreedLab. All rights reserved.
//

#import "NSString+GreedJSON.h"

@implementation NSString (GreedJSON)

- (id)toObject
{
    if (self.length == 0) {
        return nil;
    }
    NSError *error;
    NSData *data = [self dataUsingEncoding: NSUTF8StringEncoding];
    
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"** GreedJSON ** %@",[error localizedDescription]);
    }
    
    return object;
}

- (id)toObjectWithOptions:(NSJSONReadingOptions)options
{
    if (self.length == 0) {
        return nil;
    }
    NSError *error;
    NSData *data = [self dataUsingEncoding: NSUTF8StringEncoding];
    
    id object = [NSJSONSerialization JSONObjectWithData:data options:options error:&error];
    if (error) {
        NSLog(@"** GreedJSON ** %@",[error localizedDescription]);
    }
    return object;
}

@end
