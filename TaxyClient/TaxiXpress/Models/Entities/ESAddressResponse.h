//
//  ESAddressResponse.h
//  TaxiXpress
//
//  Created by Rodrigo Ibáñez Jiménez on 10/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "JSONModel.h"
#import "ESAddress.h"

@interface ESAddressResponse : JSONModel

@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSArray<ESAddress,Optional> *results;

@end
