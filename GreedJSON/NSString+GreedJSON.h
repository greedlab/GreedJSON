//
//  NSString+GreedJSON.h
//  GreedJSON
//
//  Created by Bell on 15/5/19.
//  Copyright (c) 2015年 GreedLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GreedJSON)

/**
 *  format to NSDictionary or NSArray
 *
 *  @return NSDictionary or NSArray
 */
- (__kindof NSObject*)toObject;

- (__kindof NSObject*)toObjectWithOptions:(NSJSONReadingOptions)options;

@end
