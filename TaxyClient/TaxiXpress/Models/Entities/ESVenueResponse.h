//
//  ESVenueResponse.h
//  TaxiXpress
//
//  Created by Roy on 24/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "ESVenue.h"

@interface ESVenueResponse : JSONModel

@property(nonatomic,strong)NSArray<Optional,ESVenue> *venues;

@end
