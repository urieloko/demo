//
//  ESValidator.h
//  TaxiXpress
//
//  Created by Roy on 15/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#define REGEX_ALPHANUMERIC_MAXLENGTH @"^[a-zA-Z0-9]{0,%d}$"

@interface ESValidator : NSObject

+(BOOL)validateAlphanumbericString:(NSString *)string maxLength:(int)maxLength;
+(BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern;
@end
