//
//  ESWebServiceConstants.m
//  TaxiXpress
//
//  Created by Roy on 30/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESWebServiceConstants.h"

#pragma mark - Google Maps Constants
NSString * const GM_URL_GEOCODE_LAT_LNG = @"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true_or_false";
NSString * const GM_URL_GEOCODE_ADDRESS = @"http://maps.googleapis.com/maps/api/geocode/json?address=%@";

#pragma mark - FourSquare Constants

//https://api.foursquare.com/v2/venues/explore?client_id=WY4KL20TWB42NAHPJ5EFMUKTJFSFNP13PGZREDHQMAGC213W&client_secret=YHNZPROEWES1DBSJ51GH0QDYUL2JFWAXVMMT5VUCOS40QNDD&v=20130815&ll=40.7,-74

//https://api.foursquare.com/v2/venues/search?client_id=WY4KL20TWB42NAHPJ5EFMUKTJFSFNP13PGZREDHQMAGC213W&client_secret=YHNZPROEWES1DBSJ51GH0QDYUL2JFWAXVMMT5VUCOS40QNDD&v=20130815&ll=19.2758158,-99.16608129999997

NSString * const FS_URL = @"https://api.foursquare.com/v2/venues/search?client_id=%@&client_secret=%@&v=%@&ll=%f,%f";
NSString * const FS_CLIENT_ID  = @"WY4KL20TWB42NAHPJ5EFMUKTJFSFNP13PGZREDHQMAGC213W";
NSString * const FS_CLIENT_SECRET = @"YHNZPROEWES1DBSJ51GH0QDYUL2JFWAXVMMT5VUCOS40QNDD";
NSString * const FS_VERSION = @"20130815";
