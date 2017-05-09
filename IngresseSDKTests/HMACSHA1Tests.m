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

- (void)testEncrypt {
    NSString *expected = @"qXQHLSif+/sAeXThuwvQPgWmwuI=";
    NSString *generated = [HMACSHA1 hash:@"TextToEncrypt" key:@"key"];
    
    XCTAssert([expected isEqualToString:generated]);
}

@end
