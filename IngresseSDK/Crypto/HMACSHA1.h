//
//  HMACSHA1.h
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/13/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMACSHA1 : NSObject

+ (NSString*) hash: (NSString*)text key: (NSString*)key;

@end
