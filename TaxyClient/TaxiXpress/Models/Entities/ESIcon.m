//
//  ESIcon.m
//  TaxiXpress
//
//  Created by Roy on 21/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESIcon.h"

@interface ESIcon ()
@property(nonatomic,strong)NSURL<Optional> *url;
@property(nonatomic,strong)NSString<Optional> *name;
@end

@implementation ESIcon

-(NSURL *)getUrl
{
    NSString *urlStr = nil;
    
    if (!_url) {
        urlStr = [NSString stringWithFormat:@"%@%@%@",_prefix,ICON_SIZE,_suffix];
        _url = [NSURL URLWithString:urlStr];
    }
    
    NSLog(@"URL [%@]",_url);
    
    return _url;
}

-(NSString *)getNameIcon
{
    NSURL *url = nil;
    
    if (!_name) {
        url = [self getUrl];
        _name = url.lastPathComponent;
    }
    
    NSLog(@"NAME ICON [%@]",_name);
    
    return _name;
}

-(BOOL)isEqual:(id)object
{
    ESIcon *otherIcon = nil;
    
    if ([object isKindOfClass:[ESIcon class]]) {
        otherIcon = (ESIcon *)object;
        
        return [[self getNameIcon] isEqual:[otherIcon getNameIcon]];
    }
    return NO;
    
//    if (other == self) {
//        return YES;
//    } else if (![super isEqual:other]) {
//        return NO;
//    } else {
//        return <#comparison expression#>;
//    }
}

- (NSUInteger)hash
{
    return [_name hash];
}

@end
