//
//  Copyright © 2017 Gondek. All rights reserved.
//

#import "HMACSHA1.h"
#import <XCTest/XCTest.h>

@interface HMACSHA1Tests : XCTestCase

@end

@implementation HMACSHA1Tests

- (void)testEncrypt {
    // Given
    NSString *expected = @"qXQHLSif+/sAeXThuwvQPgWmwuI=";

    // When
    NSString *generated = [HMACSHA1 hash:@"TextToEncrypt" key:@"key"];
    
    // Then
    XCTAssert([expected isEqualToString:generated]);
}

@end
