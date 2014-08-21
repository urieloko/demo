//
//  ESSnippetView.h
//  TaxiXpress
//
//  Created by Rodrigo Ibáñez Jiménez on 11/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESUtils.h"

static NSString * const SNIPPET_VIEW_NIB_NAME = @"ESSnippetView";

@interface ESSnippetView : UIView
@property (strong, nonatomic) IBOutlet UILabel *nombreLbl;
@property (strong, nonatomic) IBOutlet UILabel *placasLbl;
@property (strong, nonatomic) IBOutlet UILabel *modeloLbl;
@property (strong, nonatomic) IBOutlet UIImageView *ratingImage;

-(void)setUp;
+ (ESSnippetView *) loadViewFromNib;
@end
