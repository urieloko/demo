//
//  ESSnippetView.m
//  TaxiXpress
//
//  Created by Rodrigo Ibáñez Jiménez on 11/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESSnippetView.h"

@implementation ESSnippetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    UIColor *colorTitle = [ESUtils colorFromRGB:COLOR_TITLE_CELL_PLACE];
    UIColor *colorSubtitle = [ESUtils colorFromRGB:COLOR_SUBTITLE_CELL_PLACE];
    UIFont *fontTitle = [ESUtils fontTrebuchetMsWithSize:SIZE_SNIPPET_BIG];
    UIFont *fontSubtitle = [ESUtils fontTrebuchetMsWithSize:SIZE_SNIPPET_SMALL];
    
    _nombreLbl.textColor = colorTitle;
    _nombreLbl.font = fontTitle;
    
    _placasLbl.textColor = colorSubtitle;
    _placasLbl.font = fontSubtitle;
    
    _modeloLbl.textColor = colorSubtitle;
    _modeloLbl.font = fontSubtitle;
}

+(ESSnippetView *)loadViewFromNib
{
    ESSnippetView * snippetView = (ESSnippetView *)[[[NSBundle mainBundle] loadNibNamed:SNIPPET_VIEW_NIB_NAME owner:self options:nil] objectAtIndex:0];
    
    // Setup SnippetView
    [snippetView setUp];
    
    return snippetView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
