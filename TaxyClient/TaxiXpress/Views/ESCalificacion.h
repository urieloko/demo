//
//  ESCalificacion.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 03/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Availability.h>
#import <UIKit/UIKit.h>
enum {
    ESStarRatingDisplayFull=0,
    ESStarRatingDisplayHalf,
    ESStarRatingDisplayAccurate
};
typedef NSUInteger ESStarRatingDisplayMode;
typedef void(^ESStarRatingReturnBlock)(float rating);
@protocol ESStarRatingProtocol;
#define ESControl   UIControl
typedef UIColor     ESColor;
typedef UIImage     ESImage;

@interface ESCalificacion : ESControl

@property (nonatomic,strong) ESImage *backgroundImage;
@property (nonatomic,strong) ESImage *starHighlightedImage;
@property (nonatomic,strong) ESImage *starImage;
@property (nonatomic) NSInteger maxRating;
@property (nonatomic) float rating;
@property (nonatomic) CGFloat horizontalMargin;
@property (nonatomic) BOOL editable;
@property (nonatomic) ESStarRatingDisplayMode displayMode;
@property (nonatomic) float halfStarThreshold;

@property (nonatomic,weak) id<ESStarRatingProtocol> delegate;
@property (nonatomic,copy) ESStarRatingReturnBlock returnBlock;
@property (nonatomic,strong) ESImage *tintedStarImage;
@property (nonatomic,strong) ESImage *tintedStarHighlightedImage;
@property (nonatomic) CGColorRef backCGColor;
@end

@protocol ESStarRatingProtocol <NSObject>

@optional

-(void)starsSelectionChanged:(ESCalificacion*)control rating:(float)rating;

@end