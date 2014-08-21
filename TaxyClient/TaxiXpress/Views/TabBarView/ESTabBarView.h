//
//  ESTabBarView.h
//  TaxiXpress
//
//  Created by Roy on 22/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESTabBarView : UIView

@property (nonatomic,strong) NSString *leftTitle;
@property (nonatomic,strong) NSString *rightTitle;
@property (nonatomic,strong) void(^leftBlock)();
@property (nonatomic,strong) void(^rightBlock)();

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle leftHandler:(void(^)())leftBlock rightTitle:(NSString *)rightTitle rightBlock:(void(^)())rightBlock;
- (id)initWithCoder:(NSCoder *)aDecoder;

-(void)tapLeftTabButton;
-(void)tapRightTabButton;

@end
