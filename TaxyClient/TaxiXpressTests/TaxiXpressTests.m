//
//  TaxiXpressTests.m
//  TaxiXpressTests
//
//  Created by Roy on 24/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ESFourSquareWS.h"

@interface TaxiXpressTests : XCTestCase

@end

@implementation TaxiXpressTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    ESFourSquareWS *fsWS = [ESFourSquareWS new];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(19.2758158,99.16608129999997);
    ESSearchVenues *searchVenues = [[ESSearchVenues alloc]initWithCoordinate:coordinate];
    NSArray *venues = nil;
    
    venues = [fsWS searchPlacesWithSearchVenue:searchVenues];
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
