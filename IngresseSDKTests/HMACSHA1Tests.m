//
//  HMACSHA1Tests.m
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

#import "HMACSHA1.h"
#import <XCTest/XCTest.h>

@interface HMACSHA1Tests : XCTestCase

@end

@implementation HMACSHA1Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSString *expected = @"qXQHLSif+/sAeXThuwvQPgWmwuI=";
    NSString *generated = [HMACSHA1 hash:@"TextToEncrypt" key:@"key"];
    
    XCTAssert([expected isEqualToString:generated]);
}

@end
