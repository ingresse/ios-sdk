//
//  URLBuilder.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/8/16.
//  Copyright © 2016 Gondek. All rights reserved.
//

import Foundation

class URLBuilder {
    
    var service: IngresseService!
    
    init (_ service: IngresseService) {
        self.service = service
    }
    
    func generateAuthString() -> String {
        return "?publickey=\(service.publicKey)&signature=\()&timestamp=\()"
    }
    
    func getTimestamp() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        df.timeZone = TimeZone(abbreviation: "GMT")
        df.locale = Locale(identifier: "en_US_POSIX")
        
        return df.string(from: Date())
    }
    
    func getSignature() -> String {
        let timestamp = getTimestamp()
    }
    
    
    
    
    
    func
    
    /**
     *  Method for generating the Ingresse Authentication string.
     *  Composed by public key, signature and timestamp.
     *
     *  @return Authentication string.
     */
    + (NSString *) generateAuthString {
    NSString *authString = @"";
    
    NSString *publicKey  = @"e9424e72263bcab5d37ecb04e05505cf91d67639";
    NSString *privateKey = @"5e09cb45c8665fff9fd0d5e043d0152191943a31";
    
    NSString *data = [publicKey stringByAppendingString:dateString];
    
    NSString *computedSignature = [self hmacsha1:data key:privateKey];
    
    authString = [NSString stringWithFormat:@"?publickey=%@&signature=%@&timestamp=%@", publicKey, [self urlencode:computedSignature], [self urlencode:dateString]];
    
    return authString;
    }
    
    /**
     *  Method for encoding a string to user on a URL.
     *
     *  @param stringToEncode NSString to encode.
     *
     *  @return Encoded NSString.
     */
    + (NSString *) urlencode:(NSString*) stringToEncode {
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[stringToEncode UTF8String];
    int sourceLen = strlen((const char *)source);
    
    for (int i = 0; i < sourceLen; ++i) {
    const unsigned char thisChar = source[i];
    if (thisChar == ' '){
    [output appendString:@"+"];
    
    } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
    (thisChar >= 'a' && thisChar <= 'z') ||
    (thisChar >= 'A' && thisChar <= 'Z') ||
    (thisChar >= '0' && thisChar <= '9')) {
    [output appendFormat:@"%c", thisChar];
    
    } else {
    [output appendFormat:@"%%%02X", thisChar];
    }
    }
    
    return output;
    }
    
    /**
     *  Method for encoding a text using HMAC-SHA1 protocol.
     *
     *  @param text   Text to be encoded.
     *  @param secret Secret to be used on the encryption algorithm.
     *
     *  @return Encrypted text.
     */
    + (NSString *)hmacsha1:(NSString *)text key:(NSString *)secret {
    NSData *secretData    = [secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData *clearTextData = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char result[20];
    CCHmac(kCCHmacAlgSHA1, [secretData bytes], [secretData length], [clearTextData bytes], [clearTextData length], result);
    
    char base64Result[32];
    size_t theResultLength = 32;
    Base64EncodeData(result, 20, base64Result, &theResultLength);
    NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
    
    NSString *base64EncodedResult = [[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding];
    
    return base64EncodedResult;
    }

}
