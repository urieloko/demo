//
//  ESTabBarView.m
//  TaxiXpress
//
//  Created by Roy on 22/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESTabBarView.h"
#import "ESUtils.h"

#define WIDTH_FACTOR 0.49
#define HEIGHT_FACTOR 0.95

@interface ESTabBarView ()

@property(nonatomic,strong) UIButton *rightTabButton;
@property(nonatomic,strong) UIButton *leftTabButton;

@property (nonatomic,strong) NSLayoutConstraint *rightWidthConstraint;
@property (nonatomic,strong) NSLayoutConstraint *rightHeightConstraint;
@property (nonatomic,strong) NSLayoutConstraint *rightTrailingConstraint;
@property (nonatomic,strong) NSLayoutConstraint *rightBottomConstraint;

@property (nonatomic,strong) NSLayoutConstraint *leftWidthConstraint;
@property (nonatomic,strong) NSLayoutConstraint *leftHeightConstraint;
@property (nonatomic,strong) NSLayoutConstraint *leftLeadingConstraint;
@property (nonatomic,strong) NSLayoutConstraint *leftBottomConstraint;

-(void)setUp;
-(void)setConstraintToRightTabButton;
-(void)setConstraintToLeftTabButton;
@end

@implementation ESTabBarView

#pragma mark -
#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame leftTitle:nil leftHandler:nil rightTitle:nil rightBlock:nil];
}

-(id)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle leftHandler:(void (^)())leftBlock rightTitle:(NSString *)rightTitle rightBlock:(void (^)())rightBlock
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _leftTitle = leftTitle;
        _leftBlock = leftBlock;
        _rightTitle = rightTitle;
        _rightBlock = rightBlock;
        
        [self setUp];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    // Left Tab Button
    _leftTabButton = [[UIButton alloc]initWithFrame:CGRectZero];
    _leftTabButton.selected = YES;
    _leftTabButton.userInteractionEnabled = NO;
    
    [ESUtils setUpTabButton:_leftTabButton text:_leftTitle];
    
    [self setConstraintToLeftTabButton];
    
    [_leftTabButton addTarget:self action:@selector(tapLeftTabButton) forControlEvents:UIControlEventTouchUpInside];
    
    // Right Tab Button
    _rightTabButton = [[UIButton alloc]initWithFrame:CGRectZero];
    _rightTabButton.selected = NO;
    _rightTabButton.userInteractionEnabled = YES;
    
    [ESUtils setUpTabButton:_rightTabButton text:_rightTitle];
    
    [self setConstraintToRightTabButton];
    
    [_rightTabButton addTarget:self action:@selector(tapRightTabButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setConstraintToRightTabButton
{
    [_rightTabButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:_rightTabButton];
    
    _rightWidthConstraint = [NSLayoutConstraint constraintWithItem:_rightTabButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:WIDTH_FACTOR constant:0.0];
    _rightHeightConstraint = [NSLayoutConstraint constraintWithItem:_rightTabButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:HEIGHT_FACTOR constant:0.0];
    _rightBottomConstraint = [NSLayoutConstraint constraintWithItem:_rightTabButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    _rightTrailingConstraint = [NSLayoutConstraint constraintWithItem:_rightTabButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    
    [self addConstraint:_rightWidthConstraint];
    [self addConstraint:_rightHeightConstraint];
    [self addConstraint:_rightBottomConstraint];
    [self addConstraint:_rightTrailingConstraint];
}

-(void)setConstraintToLeftTabButton
{
    [_leftTabButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:_leftTabButton];
    
    _leftWidthConstraint = [NSLayoutConstraint constraintWithItem:_leftTabButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:WIDTH_FACTOR constant:0.0];
    _leftHeightConstraint = [NSLayoutConstraint constraintWithItem:_leftTabButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:HEIGHT_FACTOR constant:0.0];
    _leftBottomConstraint = [NSLayoutConstraint constraintWithItem:_leftTabButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    _leftLeadingConstraint = [NSLayoutConstraint constraintWithItem:_leftTabButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    
    [self addConstraint:_leftWidthConstraint];
    [self addConstraint:_leftHeightConstraint];
    [self addConstraint:_leftBottomConstraint];
    [self addConstraint:_leftLeadingConstraint];
}

#pragma mark - Getters and Setters Methods
-(void)setLeftTitle:(NSString *)leftTitle
{
    if (leftTitle) {
        _leftTitle = leftTitle;
        
        if (_leftTabButton) {
            [ESUtils setUpTabButton:_leftTabButton text:_leftTitle];
        }
    } else {
        _leftTitle = @"";
    }
}

-(void)setRightTitle:(NSString *)rightTitle
{
    if (rightTitle) {
        _rightTitle = rightTitle;
        
        if (_rightTabButton) {
            [ESUtils setUpTabButton:_rightTabButton text:_rightTitle];
        }
    }else {
        _rightTitle = @"";
    }
}

#pragma mark - Action Methods

-(void)tapLeftTabButton
{
    if (!_leftTabButton.selected) {
        
        NSLog(@"Call tapLeftTabButton");
        
        _leftTabButton.selected = YES;
        _leftTabButton.userInteractionEnabled = NO;
        
        _rightTabButton.selected = NO;
        _rightTabButton.userInteractionEnabled = YES;
        
        if (_leftBlock) {
            _leftBlock();
        }
    }
}

-(void)tapRightTabButton
{
    if (!_rightTabButton.selected) {
        
        NSLog(@"Call tapRightTabButton");
        
        _leftTabButton.selected = NO;
        _leftTabButton.userInteractionEnabled = YES;
        
        _rightTabButton.selected = YES;
        _rightTabButton.userInteractionEnabled = NO;
        
        if (_rightBlock) {
            _rightBlock();
        }
    }
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
