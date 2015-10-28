# GreedJSON [![Build Status](https://travis-ci.org/greedlab/GreedJSON.svg?branch=master)](https://travis-ci.org/greedlab/GreedJSON)
Format JSON based on NSJSONSerialization
# Installation
pod 'GreedJSON'
# Usage
```objc
#import "GreedJSON.h"
```
## [NSArray+GreedJSON](https://github.com/greedlab/GreedJSON/blob/master/GreedJSON/NSArray%2BGreedJSON.h)
```objc
- (NSString*)gr_JSONString;
- (NSData*)gr_JSONData;
```
## [NSData+GreedJSON](https://github.com/greedlab/GreedJSON/blob/master/GreedJSON/NSData%2BGreedJSON.h)
```objc
// format to NSDictionary or NSArray
- (__kindof NSObject*)toObject
```
## [NSDictionary+GreedJSON](https://github.com/greedlab/GreedJSON/blob/master/GreedJSON/NSDictionary%2BGreedJSON.h)
```objc
- (NSString*)gr_JSONString;
- (NSData*)gr_JSONData;
```
## [NSString+GreedJSON](https://github.com/greedlab/GreedJSON/blob/master/GreedJSON/NSString%2BGreedJSON.h)
```objc
// format to NSDictionary or NSArray
- (__kindof NSObject*)toObject
```
# Release Notes
* 0.0.1 first version
* 0.0.2 change method toObject to gr_object

# LICENSE
MIT
