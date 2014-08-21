//
//  Draw2D.m
//  Draw2D
//
//  Created by Rodrigo Ibáñez Jiménez on 01/06/14.
//  Copyright (c) 2014 Rodrigo Ibáñez Jiménez. All rights reserved.
//

#import "Draw2D.h"

@implementation Draw2D

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // First Line
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGFloat components[] = {0.0f,0.0f,1.0f,1.0f};
//    CGColorRef color = CGColorCreate(colorSpace, components);
//    
//    CGContextSetLineWidth(context, 2.0f);
//    CGContextSetStrokeColorWithColor(context, color);
//    CGContextMoveToPoint(context, 30.0f, 30.0f);
//    CGContextAddLineToPoint(context, 300.0f, 400.0f);
//    CGContextStrokePath(context);
//    CGColorRelease(color);
//    CGColorSpaceRelease(colorSpace);
    
    // Second Line
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorRef color = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f].CGColor;
//    
//    CGContextSetLineWidth(context, 2.0f);
//    CGContextSetStrokeColorWithColor(context, color);
//    CGContextMoveToPoint(context, 30.0f, 30.0f);
//    CGContextAddLineToPoint(context, 300.0f, 400.0f);
//    CGContextStrokePath(context);
    
    // Path
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorRef color = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f].CGColor;
//    
//    CGContextSetLineWidth(context, 2.0f);
//    CGContextSetStrokeColorWithColor(context, color);
//    CGContextMoveToPoint(context, 100.0f, 100.0f);
//    CGContextAddLineToPoint(context, 150.0f, 150.0f);
//    CGContextAddLineToPoint(context, 100.0f, 200.0f);
//    CGContextAddLineToPoint(context, 50.0f, 150.0f);
//    CGContextAddLineToPoint(context, 100.0f, 100.0f);
//    CGContextStrokePath(context);
    
    // Rectangle
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorRef color = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f].CGColor;
//    CGRect rectangle = CGRectMake(60.0f, 170.0f, 200.0f, 80.0f);
//    
//    CGContextSetLineWidth(context, 2.0f);
//    CGContextSetStrokeColorWithColor(context, color);
//    CGContextAddRect(context, rectangle);
//    CGContextStrokePath(context);
    
    // Ellipse
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorRef color = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f].CGColor;
//    CGRect ellipse = CGRectMake(60.0f, 170.0f, 200.0f, 80.0f);
//    
//    CGContextSetLineWidth(context, 2.0f);
//    CGContextSetStrokeColorWithColor(context, color);
//    CGContextAddEllipseInRect(context, ellipse);
//    CGContextStrokePath(context);
    
    // Path Fill
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorRef color = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f].CGColor;
//    
//    CGContextSetLineWidth(context, 2.0f);
//    CGContextSetStrokeColorWithColor(context, color);
//    CGContextMoveToPoint(context, 100.0f, 100.0f);
//    CGContextAddLineToPoint(context, 150.0f, 150.0f);
//    CGContextAddLineToPoint(context, 100.0f, 200.0f);
//    CGContextAddLineToPoint(context, 50.0f, 150.0f);
//    CGContextAddLineToPoint(context, 100.0f, 100.0f);
//    CGContextSetFillColorWithColor(context, color);
//    CGContextFillPath(context);
    
    // Rectangle Fill
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorRef colorStroke = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f].CGColor;
//    CGColorRef colorFill = [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:1.0f].CGColor;
//    CGRect rectangle = CGRectMake(60.0f, 170.0f, 200.0f, 80.0f);
//    
//    CGContextSetLineWidth(context, 2.0f);
//    CGContextSetStrokeColorWithColor(context, colorStroke);
//    CGContextAddRect(context, rectangle);
//    CGContextStrokePath(context);
//    
//    CGContextSetFillColorWithColor(context, colorFill);
//    CGContextFillRect(context, rectangle);

    // Arc
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorRef color = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f].CGColor;
//    
//    CGContextSetStrokeColorWithColor(context, color);
//    CGContextSetLineWidth(context, 5.0f);
//    CGContextMoveToPoint(context, 100, 100);
//    CGContextAddArcToPoint(context, 100.0f, 200.f, 300.0f, 200.0f, 100.0f);
//    CGContextStrokePath(context);
    
    // Cubic Béizer Curve
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorRef color = [UIColor colorWithRed:1 green:0 blue:0 alpha:1].CGColor;
//    
//    CGContextSetLineWidth(context, 4.0f);
//    CGContextSetStrokeColorWithColor(context, color);
//    CGContextMoveToPoint(context, 10.0f, 10.0f);
//    CGContextAddCurveToPoint(context, 0, 50, 300, 250, 300, 400);
//    CGContextStrokePath(context);
    
    // Quadratic Béizer Curve
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorRef color = [UIColor colorWithRed:1 green:0 blue:0 alpha:1].CGColor;
    
    CGContextSetLineWidth(context, 4.0f);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextMoveToPoint(context, 10.0f, 200.0f);
    CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200);
    CGContextStrokePath(context);
}

@end
