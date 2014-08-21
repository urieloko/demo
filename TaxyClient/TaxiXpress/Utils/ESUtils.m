//
//  ESUtils.m
//  TaxiXpress
//
//  Created by Roy on 30/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESUtils.h"

@implementation ESUtils

+(UIFont *)fontTrebuchetMsWithSize:(CGFloat) size
{
    return [UIFont fontWithName:FONT_TREBUCHETMS size:size];
}

+(UIFont *)fontTrebuchetBoldMsWithSize:(CGFloat) size
{
    return [UIFont fontWithName:FONT_TREBUCHETMS_BOLD size:size];
}

+(UIFont *)fontFabulous50sNormalWithSize:(CGFloat) size
{
    return [UIFont fontWithName:FONT_FABULOUSS0S_NORMAL size:size];
}

+(UIFont *)fontKOMIKAXWithSize:(CGFloat) size
{
    return [UIFont fontWithName:FONT_KOMIKAX size:size];
}

+(UIColor *)colorFromRGB:(int)rgbValue
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

+(void)setUpLabel:(UILabel *)label text:(NSString *)text font:(UIFont *)font color:(UIColor *)color
{
    label.text = text;
    label.font = font;
    label.textColor = color;
}

+(void)setUpTabButton:(UIButton *)tabButton text:(NSString *)text
{
    UIImage *tabOnImage = nil;
    UIImage *tabOffImage = nil;
    UIColor *tabOnColor = nil;
    UIColor *tabOffColor = nil;
    
    if (tabButton) {
        tabOnImage = [[UIImage imageNamed:@"tabON"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        tabOffImage = [[UIImage imageNamed:@"tabOFF"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        
        tabOnColor = [ESUtils colorFromRGB:COLOR_TAB_ON];
        tabOffColor = [ESUtils colorFromRGB:COLOR_TAB_OFF];
        
        [tabButton setBackgroundImage:tabOnImage forState:UIControlStateSelected];
        [tabButton setBackgroundImage:tabOffImage forState:UIControlStateNormal];
        [tabButton setTitleColor:tabOnColor forState:UIControlStateSelected];
        [tabButton setTitleColor:tabOffColor forState:UIControlStateNormal];
        
        if (text) {
            [tabButton setTitle:text forState:UIControlStateSelected];
            [tabButton setTitle:text forState:UIControlStateNormal];
        }
        
        tabButton.titleLabel.font = [ESUtils fontTrebuchetMsWithSize:SIZE_TEXT_TAB];
    }
}

+(void)setUpView:(UIView *)view cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor {
    [view setBackgroundColor:backgroundColor];
    view.layer.cornerRadius = cornerRadius;
}

+(void)setUpButton:(UIButton *)button colorTitle:(UIColor *)titleColor title:(NSString *)title forState:(UIControlState)state {
    [button setTitleColor:titleColor forState:state];
    [button setTitle:title forState:state];
}

+(UIAlertView *)generateInputAlertViewWithTitle:(NSString *)title message:(NSString *)message keyboardType:(UIKeyboardType)keyboardType alertDelegate:(id<UIAlertViewDelegate>)alertDelegate tag:(NSInteger)tag textFieldDelegate:(id<UITextFieldDelegate>)textFieldDelegate
{
    UIAlertView * alert = nil;
    NSString *cancelarStr = NSLocalizedString(LBL_CANCEL, nil);
    NSString *confirmarStr = NSLocalizedString(LBL_CONFIRM, nil);
    UIAlertViewStyle alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = nil;
    
    alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:alertDelegate cancelButtonTitle:cancelarStr otherButtonTitles:confirmarStr, nil];
    
    alert.alertViewStyle=alertViewStyle;
    
    textField = [alert textFieldAtIndex:0];
    textField.keyboardType = keyboardType;
    textField.delegate = textFieldDelegate;
    
    alert.tag = tag;
    
    return alert;
}

+(void)showProgressWithBackgroundColor:(UIColor *)backgroundColor foregroundColor:(UIColor *)foregroundColor status:(NSString *)status maskType:(SVProgressHUDMaskType)maskType
{
    [SVProgressHUD setBackgroundColor:backgroundColor];
    [SVProgressHUD setForegroundColor:foregroundColor];
    [SVProgressHUD showWithStatus:status maskType:maskType];
//    [SVProgressHUD setBackgroundColor:[ESUtils colorFromRGB:COLOR_AQUA_PLACE]];
//    [SVProgressHUD setForegroundColor:[ESUtils colorFromRGB:COLOR_TITLE_CELL_PLACE]];
//    [SVProgressHUD showWithStatus:@"Buscando ..." maskType:SVProgressHUDMaskTypeNone];
}
+(void)hideProgress
{
    [SVProgressHUD dismiss];
}

@end
