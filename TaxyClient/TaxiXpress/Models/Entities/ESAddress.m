//
//  ESAddress.m
//  TaxiXpress
//
//  Created by Rodrigo Ibáñez Jiménez on 10/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESAddress.h"

@implementation ESAddressComponent

@end

@interface ESAddress ()

@end

@implementation ESAddress

-(ESAddressComponent *) getAddressComponentOfType:(NSString *) type {
    ESAddressComponent *addressComponent = nil;
    
    for (ESAddressComponent *_addressComponent in _address_components) {
        for (NSString *_type in _addressComponent.types) {
            if ([_type isEqualToString:type]) {
                addressComponent = _addressComponent;
                break;
            }
        }
    }
    
    return addressComponent;
}

-(NSString *)getStreetOfAddress {
    NSString *street = nil;
    ESAddressComponent *addressComponent = nil;
    
    addressComponent = [self getAddressComponentOfType:STREET];
    
    if (addressComponent) {
        street = addressComponent.short_name;
    }
    
    return street;
}
-(NSString *)getNumberOfAddress {
    NSString *number = nil;
    
    ESAddressComponent *addressComponent = nil;
    
    addressComponent = [self getAddressComponentOfType:STREET_NUMBER];
    
    if (addressComponent) {
        number = addressComponent.short_name;
    }
    
    return number;
}

-(NSString *)getStreetNumberFormatOfAddress {
    NSString *street = nil;
    NSString *number = nil;
    NSString *streetNumber = nil;
    
    street = [self getStreetOfAddress];
    number = [self getNumberOfAddress];
    
    streetNumber = [NSString stringWithFormat:@"%@ %@",street,number];
    
    return streetNumber;
}

+(ESAddress *)getStreetAddress:(NSArray *)address
{
    ESAddress *_address = nil;
    
    if (address) {
        for (ESAddress *addressItem in address) {
            for (NSString *typeAddress in addressItem.types) {
                if ([typeAddress isEqualToString:STREET_ADDRESS]) {
                    _address = addressItem;
                    break;
                }
            }
        }
    }
    
    return _address;
}

@end
