//
//  PodProductTests.m
//  PodProductTests
//
//  Created by wzk on 2017/6/12.
//  Copyright © 2017年 wzk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AbstractFactoryPatternDemo.h"
#import "SingleObject.h"
@interface PodProductTests : XCTestCase

@end

@implementation PodProductTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSLog(@"setUp");
    [SingleObject shareSingleObject].index = 100;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    NSLog(@"tearDown");
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSLog(@"testExample");
//    [AbstractFactoryPatternDemo testColorFuntory];
    /**测试工厂
    [AbstractFactoryPatternDemo testShapeFuntory];
     */
    
    /**测试单例
     NSLog(@"%ld",(long)[SingleObject shareSingleObject].index);

     */
    
}
- (void)testMyClass
{
    NSLog(@"testMyClass");
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    NSLog(@"testPerformanceExample");
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSLog(@"measureBlock");
        
        
    }];
    
    
    
}

@end
