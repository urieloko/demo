//
//  ESUtils.h
//  TaxiXpress
//
//  Created by Roy on 30/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESUtilConstants.h"
#import "SVProgressHUD.h"

@interface ESUtils : NSObject

+(UIFont *)fontTrebuchetMsWithSize:(CGFloat) size;
+(UIFont *)fontTrebuchetBoldMsWithSize:(CGFloat) size;
+(UIFont *)fontFabulous50sNormalWithSize:(CGFloat) size;
+(UIFont *)fontKOMIKAXWithSize:(CGFloat) size;
+(UIColor *)colorFromRGB:(int)rgbValue;

+(void)setUpLabel:(UILabel *)label text:(NSString *)text font:(UIFont *)font color:(UIColor *)color;
+(void)setUpTabButton:(UIButton *)tabButton text:(NSString *)text;
+(void)setUpView:(UIView *)view cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor;
+(void)setUpButton:(UIButton *)button colorTitle:(UIColor *)titleColor title:(NSString *)title forState:(UIControlState)state;

+(UIAlertView *)generateInputAlertViewWithTitle:(NSString *)title message:(NSString *)message keyboardType:(UIKeyboardType)keyboardType alertDelegate:(id<UIAlertViewDelegate>)alertDelegate tag:(NSInteger)tag textFieldDelegate:(id<UITextFieldDelegate>)textFieldDelegate;

+(void)showProgressWithBackgroundColor:(UIColor *)backgroundColor foregroundColor:(UIColor *)foregroundColor status:(NSString *)status maskType:(SVProgressHUDMaskType)maskType;
+(void)hideProgress;

@end
