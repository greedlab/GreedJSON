//
//  ExampleUnitTests.m
//  ExampleUnitTests
//
//  Created by Bell on 15/10/28.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GreedJSON.h"
#import "GRTestModel.h"

@interface ExampleUnitTests : XCTestCase

@end

@implementation ExampleUnitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testJSON
{
//    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://api.github.com/search/repositories?q=GreedJSON"]];
//    {
//        // test NSData to NSObject
//        NSObject *object = [data gr_object];
//        NSLog(@"NSData to NSObject:%@",object);
//        
//        if ([object isKindOfClass:[NSDictionary class]]) {
//            
//            // test NSDictionary to NSString
//            NSDictionary *dictionary = (NSDictionary*)object;
//            NSString *string = [dictionary gr_JSONString];
//            NSLog(@"NSDictionary to NSString:%@",string);
//            
//            // test NSArray to NSString
//            NSArray *items = [dictionary objectForKey:@"items"];
//            if (items && [items isKindOfClass:[NSArray class]]) {
//                NSString *string = [items gr_JSONString];
//                NSLog(@"NSArray to NSString:%@",string);
//            }
//        } else if ([object isKindOfClass:[NSArray class]]) {
//            // test NSArray to NSString
//            NSString *string = [(NSArray*)object gr_JSONString];
//            NSLog(@"NSArray to NSString:%@",string);
//        }
//    }
//    
//    {
//        NSString *string =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        // test NSString to object
//        NSObject *object = [string gr_object];
//        NSLog(@"NSString to object:%@",object);
//    }
}

- (void)testModel
{
    GRTestModel *model = [[GRTestModel alloc] init];
    [model setKey0:@"key0"];
    [model setKey2:[NSArray arrayWithObjects:[[GRTestModel alloc] init], nil]];
    [model setKey3:@"key3"];
    [model setKey4:@"key4"];
    [model setKey5:5];
    [model setKey6:@"key6"];
    NSDictionary *dictionary = [model gr_dictionary];
    NSLog(@"1 model to dictionary:%@",dictionary);
    
    GRTestModel *resultMode = [GRTestModel gr_objectFromDictionary:dictionary];
    
    NSLog(@"2 model to dictionary:%@",[resultMode gr_dictionary]);
}

@end
