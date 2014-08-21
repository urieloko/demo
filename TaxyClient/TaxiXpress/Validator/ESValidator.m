//
//  ESValidator.m
//  TaxiXpress
//
//  Created by Roy on 15/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESValidator.h"

@implementation ESValidator

+(BOOL)validateAlphanumbericString:(NSString *)string maxLength:(int)maxLength
{
    return [ESValidator validateString:string withPattern:[NSString stringWithFormat:REGEX_ALPHANUMERIC_MAXLENGTH,maxLength]];
}

+(BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = nil;
    NSRange textRange;
    NSRange matchRange;
    BOOL isValidated;
    
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(regex, @"Unable to create regular expression");
    
    textRange = NSMakeRange(0, string.length);
    
    matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportCompletion range:textRange];
    
    isValidated = matchRange.location != NSNotFound;
    
    return isValidated;
}

@end
