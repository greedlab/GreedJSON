//
//  NSData+GreedJSON.h
//  GreedJSON
//
//  Created by Bell on 15/5/19.
//  Copyright (c) 2015年 GreedLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (GreedJSON)

/**
 *  NSData转成NSDictionary 或者 NSArray
 *
 *  @return NSDictionary 或者 NSArray
 */
- (__kindof NSObject*)toObject;

- (__kindof NSObject*)toObjectWithOptions:(NSJSONReadingOptions)options;

@end
