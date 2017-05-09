//
//  HMACSHA1.m
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/13/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

#import "HMACSHA1.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation HMACSHA1

+ (NSString *)hash:(NSString *)text key:(NSString *)key {
    
    NSData *secretData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *clearTextData = [text dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[20];
    CCHmac(kCCHmacAlgSHA1, [secretData bytes], [secretData length], [clearTextData bytes], [clearTextData length], result);
    
    NSData *theData = [[NSData dataWithBytes:result length:20] base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSString *base64EncodedResult = [[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding];
    
    return base64EncodedResult;
}

@end
