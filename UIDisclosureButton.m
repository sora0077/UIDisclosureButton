//
//  UIDisclosureButton.m
//  UIDisclosureButton
//
//  Created by t_hayashi on 12/03/21.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "UIDisclosureButton.h"

#define BUTTON_HEIGHT 25.0

@interface UIDisclosureButton ()
- (void)drawNormal;
- (void)drawHighlighted;
- (void)drawDisable;
@end

@implementation UIDisclosureButton

+ (id)buttonWithType:(UIButtonType)buttonType
{
	return [[[self alloc] init] autorelease];
}

- (id)init
{
	self = [super init];
	if (self) {
		self.titleLabel.font = [UIFont systemFontOfSize:16];
		self.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
		[self setTitleEdgeInsets:UIEdgeInsetsMake(2, 8, 0, 18)];
		[self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		[self setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
	}
	return self;
}

- (void)drawRect:(CGRect)rect
{
	if (self.isEnabled) {
		if (self.isHighlighted) {
			[self drawHighlighted];
		} else {
			[self drawNormal];
		}
	} else {
		[self drawDisable];
	}
}

- (void)setFrame:(CGRect)frame
{
	CGRect rect = frame;
	rect.size.height = BUTTON_HEIGHT;
	[super setFrame:rect];
}

//- (CGSize)sizeThatFits:(CGSize)size
//{
//	CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, self.titleLabel.frame.size.height) lineBreakMode:UILineBreakModeWordWrap];
//	
//	return CGSizeMake(textSize.width + 30, BUTTON_HEIGHT);
//}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled
{
	[super setEnabled:enabled];
	[self setNeedsDisplay];
}

#pragma mark - Private method
- (void)drawNormal
{
	//// General Declarations
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	//// Color Declarations
	UIColor* backgroundColorTop = [UIColor colorWithRed: 0.62 green: 0.71 blue: 0.91 alpha: 1];
	UIColor* backgroundColorBottom = [UIColor colorWithRed: 0.44 green: 0.48 blue: 0.83 alpha: 1];
	UIColor* frontColorTop = [UIColor colorWithRed: 0.86 green: 0.9 blue: 0.97 alpha: 1];
	UIColor* frontColorBottom = [UIColor colorWithRed: 0.72 green: 0.79 blue: 0.94 alpha: 1];
	UIColor* indicatorColorTop = [UIColor colorWithRed: 0.42 green: 0.57 blue: 0.88 alpha: 1];
	UIColor* darkShadowColor = [UIColor colorWithRed: 0.24 green: 0.43 blue: 0.84 alpha: 1];
	UIColor* lightShadowColor = [UIColor colorWithRed: 0.87 green: 0.9 blue: 0.97 alpha: 1];
	UIColor* indicatorColorBottom = [UIColor colorWithRed: 0.25 green: 0.42 blue: 0.84 alpha: 1];
	UIColor* indicatorShadowColor = [UIColor colorWithRed: 0.09 green: 0.28 blue: 0.8 alpha: 1];
	
	
	//// Gradient Declarations
	NSArray* buttonBackgroundGradientColors = [NSArray arrayWithObjects: 
											   (id)backgroundColorTop.CGColor, 
											   (id)backgroundColorBottom.CGColor, nil];
	CGFloat buttonBackgroundGradientLocations[] = {0, 1};
	CGGradientRef buttonBackgroundGradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)buttonBackgroundGradientColors, buttonBackgroundGradientLocations);
	NSArray* buttonFrontGradientColors = [NSArray arrayWithObjects: 
										  (id)frontColorTop.CGColor, 
										  (id)frontColorBottom.CGColor, nil];
	CGFloat buttonFrontGradientLocations[] = {0, 1};
	CGGradientRef buttonFrontGradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)buttonFrontGradientColors, buttonFrontGradientLocations);
	NSArray* indicatorGradientColors = [NSArray arrayWithObjects: 
										(id)indicatorColorTop.CGColor, 
										(id)[UIColor colorWithRed: 0.33 green: 0.49 blue: 0.86 alpha: 1].CGColor, 
										(id)indicatorColorBottom.CGColor, nil];
	CGFloat indicatorGradientLocations[] = {0, 0.65, 1};
	CGGradientRef indicatorGradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)indicatorGradientColors, indicatorGradientLocations);
	
	//// Shadow Declarations
	CGColorRef lightShadow = lightShadowColor.CGColor;
	CGSize lightShadowOffset = CGSizeMake(0, 1);
	CGFloat lightShadowBlurRadius = 0;
	CGColorRef darkShadow = darkShadowColor.CGColor;
	CGSize darkShadowOffset = CGSizeMake(0, 1);
	CGFloat darkShadowBlurRadius = 0;
	
	
	//// Button Background Rectangle Drawing
	UIBezierPath* buttonBackgroundRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, self.frame.size.width, 25) cornerRadius: 12.5];
	CGContextSaveGState(context);
	[buttonBackgroundRectanglePath addClip];
	CGContextDrawLinearGradient(context, buttonBackgroundGradient, CGPointMake(15, -0), CGPointMake(15, 25), 0);
	CGContextRestoreGState(context);
	
	
	
	//// Button Front Rectangle Drawing
	UIBezierPath* buttonFrontRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 0.5, self.frame.size.width-1, 24) cornerRadius: 12];
	CGContextSaveGState(context);
	[buttonFrontRectanglePath addClip];
	CGContextDrawLinearGradient(context, buttonFrontGradient, CGPointMake(15, 0.5), CGPointMake(15, 24.5), 0);
	CGContextRestoreGState(context);
	
	
	CGFloat offset = self.frame.size.width - 30;
	//// Indicator Drawing
	UIBezierPath* indicatorPath = [UIBezierPath bezierPath];
	[indicatorPath moveToPoint: CGPointMake(24 + offset, 12.75)];
	[indicatorPath addLineToPoint: CGPointMake(17.25 + offset, 20)];
	[indicatorPath addLineToPoint: CGPointMake(15 + offset, 17.75)];
	[indicatorPath addLineToPoint: CGPointMake(19.75 + offset, 13)];
	[indicatorPath addLineToPoint: CGPointMake(15 + offset, 8.25)];
	[indicatorPath addLineToPoint: CGPointMake(17.25 + offset, 6)];
	[indicatorPath addLineToPoint: CGPointMake(24 + offset, 12.75)];
	[indicatorPath closePath];
	CGContextSaveGState(context);
	CGContextSetShadowWithColor(context, lightShadowOffset, lightShadowBlurRadius, lightShadow);
	CGContextSetFillColorWithColor(context, lightShadow);
	[indicatorPath fill];
	[indicatorPath addClip];
	CGContextDrawLinearGradient(context, indicatorGradient, CGPointMake(19.5, 6), CGPointMake(19.5, 20), 0);
	
	////// Indicator Inner Shadow
	CGRect indicatorBorderRect = CGRectInset([indicatorPath bounds], -darkShadowBlurRadius, -darkShadowBlurRadius);
	indicatorBorderRect = CGRectOffset(indicatorBorderRect, -darkShadowOffset.width, -darkShadowOffset.height);
	indicatorBorderRect = CGRectInset(CGRectUnion(indicatorBorderRect, [indicatorPath bounds]), -1, -1);
	
	UIBezierPath* indicatorNegativePath = [UIBezierPath bezierPathWithRect: indicatorBorderRect];
	[indicatorNegativePath appendPath: indicatorPath];
	indicatorNegativePath.usesEvenOddFillRule = YES;
	
	CGContextSaveGState(context);
	{
		CGFloat xOffset = darkShadowOffset.width + round(indicatorBorderRect.size.width);
		CGFloat yOffset = darkShadowOffset.height;
		CGContextSetShadowWithColor(context,
									CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
									darkShadowBlurRadius,
									darkShadow);
		
		[indicatorPath addClip];
		CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(indicatorBorderRect.size.width), 0);
		[indicatorNegativePath applyTransform: transform];
		[[UIColor grayColor] setFill];
		[indicatorNegativePath fill];
	}
	CGContextRestoreGState(context);
	
	CGContextRestoreGState(context);
	
	//// Bezier Drawing
	UIBezierPath* bezierPath = [UIBezierPath bezierPath];
	[bezierPath moveToPoint: CGPointMake(15.5 + offset, 18)];
	[bezierPath addLineToPoint: CGPointMake(19.5 + offset, 14)];
	[bezierPath addLineToPoint: CGPointMake(19.5 + offset, 14)];
	[indicatorShadowColor setStroke];
	bezierPath.lineWidth = 0.5;
	[bezierPath stroke];
	
	//// Cleanup
	CGGradientRelease(buttonBackgroundGradient);
	CGGradientRelease(buttonFrontGradient);
	CGColorSpaceRelease(colorSpace);
}

- (void)drawHighlighted
{
	//// General Declarations
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	//// Color Declarations
	UIColor* backgroundColorTop = [UIColor colorWithRed: 0.17 green: 0.4 blue: 0.87 alpha: 1];
	UIColor* backgroundColorBottom = [UIColor colorWithRed: 0.06 green: 0.16 blue: 0.87 alpha: 1];
	UIColor* frontColorTop = [UIColor colorWithRed: 0.28 green: 0.51 blue: 1 alpha: 1];
	UIColor* frontColorBottom = [UIColor colorWithRed: 0.17 green: 0.29 blue: 1 alpha: 1];
	UIColor* darkShadowColor = [UIColor colorWithRed: 0.07 green: 0.28 blue: 1 alpha: 1];
	
	//// Gradient Declarations
	NSArray* buttonBackgroundGradientColors = [NSArray arrayWithObjects: 
											   (id)backgroundColorTop.CGColor, 
											   (id)backgroundColorBottom.CGColor, nil];
	CGFloat buttonBackgroundGradientLocations[] = {0, 1};
	CGGradientRef buttonBackgroundGradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)buttonBackgroundGradientColors, buttonBackgroundGradientLocations);
	NSArray* buttonFrontGradientColors = [NSArray arrayWithObjects: 
										  (id)frontColorTop.CGColor, 
										  (id)frontColorBottom.CGColor, nil];
	CGFloat buttonFrontGradientLocations[] = {0, 1};
	CGGradientRef buttonFrontGradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)buttonFrontGradientColors, buttonFrontGradientLocations);
	
	//// Shadow Declarations
	CGColorRef darkShadow = darkShadowColor.CGColor;
	CGSize darkShadowOffset = CGSizeMake(0, -1);
	CGFloat darkShadowBlurRadius = 0;
	
	
	//// Button Background Rectangle Drawing
	UIBezierPath* buttonBackgroundRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, self.frame.size.width, 25) cornerRadius: 12.5];
	CGContextSaveGState(context);
	[buttonBackgroundRectanglePath addClip];
	CGContextDrawLinearGradient(context, buttonBackgroundGradient, CGPointMake(15, -0), CGPointMake(15, 25), 0);
	CGContextRestoreGState(context);
	
	
	
	//// Button Front Rectangle Drawing
	UIBezierPath* buttonFrontRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 0.5, self.frame.size.width-1, 24) cornerRadius: 12];
	CGContextSaveGState(context);
	[buttonFrontRectanglePath addClip];
	CGContextDrawLinearGradient(context, buttonFrontGradient, CGPointMake(15, 0.5), CGPointMake(15, 24.5), 0);
	CGContextRestoreGState(context);
	
	
	
	//// Indicator Drawing
	CGFloat offset = self.frame.size.width - 30;
	UIBezierPath* indicatorPath = [UIBezierPath bezierPath];
	[indicatorPath moveToPoint: CGPointMake(24 + offset, 12.75)];
	[indicatorPath addLineToPoint: CGPointMake(17.25 + offset, 20)];
	[indicatorPath addLineToPoint: CGPointMake(15 + offset, 17.75)];
	[indicatorPath addLineToPoint: CGPointMake(19.75 + offset, 13)];
	[indicatorPath addLineToPoint: CGPointMake(15 + offset, 8.25)];
	[indicatorPath addLineToPoint: CGPointMake(17.25 + offset, 6)];
	[indicatorPath addLineToPoint: CGPointMake(24 + offset, 12.75)];
	[indicatorPath closePath];
	CGContextSaveGState(context);
	CGContextSetShadowWithColor(context, darkShadowOffset, darkShadowBlurRadius, darkShadow);
	[[UIColor whiteColor] setFill];
	[indicatorPath fill];
	CGContextRestoreGState(context);
	
	
	//// Cleanup
	CGGradientRelease(buttonBackgroundGradient);
	CGGradientRelease(buttonFrontGradient);
	CGColorSpaceRelease(colorSpace);
}

- (void)drawDisable
{
	//// General Declarations
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	//// Color Declarations
	UIColor* backgroundColorTop = [UIColor colorWithRed: 0.62 green: 0.71 blue: 0.91 alpha: 1];
	UIColor* backgroundColorTopDisabled = [backgroundColorTop colorWithAlphaComponent: 0.5];
	UIColor* backgroundColorBottom = [UIColor colorWithRed: 0.44 green: 0.48 blue: 0.83 alpha: 1];
	UIColor* backgroundColorBottomDisabled = [backgroundColorBottom colorWithAlphaComponent: 0.5];
	UIColor* frontColorTop = [UIColor colorWithRed: 0.86 green: 0.9 blue: 0.97 alpha: 1];
	UIColor* frontColorTopDisabled = [frontColorTop colorWithAlphaComponent: 0.5];
	UIColor* frontColorBottom = [UIColor colorWithRed: 0.72 green: 0.79 blue: 0.94 alpha: 1];
	UIColor* frontColorBottomDisabled = [frontColorBottom colorWithAlphaComponent: 0.5];
	UIColor* indicatorColorTop = [UIColor colorWithRed: 0.42 green: 0.57 blue: 0.88 alpha: 1];
	UIColor* indicatorColorTopDisabled = [indicatorColorTop colorWithAlphaComponent: 0.3];
	UIColor* darkShadowColor = [UIColor colorWithRed: 0.24 green: 0.43 blue: 0.84 alpha: 1];
	UIColor* darkShadowColorDisabled = [darkShadowColor colorWithAlphaComponent: 0.3];
	UIColor* lightShadowColor = [UIColor colorWithRed: 0.87 green: 0.9 blue: 0.97 alpha: 1];
	UIColor* lightShadowColorDisabled = [lightShadowColor colorWithAlphaComponent: 0.3];
	UIColor* indicatorColorBottom = [UIColor colorWithRed: 0.25 green: 0.42 blue: 0.84 alpha: 1];
	UIColor* indicatorColorBottomDisabled = [indicatorColorBottom colorWithAlphaComponent: 0.3];
	
	//// Gradient Declarations
	NSArray* buttonBackgroundGradientColors = [NSArray arrayWithObjects: 
											   (id)backgroundColorTopDisabled.CGColor, 
											   (id)backgroundColorBottomDisabled.CGColor, nil];
	CGFloat buttonBackgroundGradientLocations[] = {0, 1};
	CGGradientRef buttonBackgroundGradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)buttonBackgroundGradientColors, buttonBackgroundGradientLocations);
	NSArray* buttonFrontGradientColors = [NSArray arrayWithObjects: 
										  (id)frontColorTopDisabled.CGColor, 
										  (id)frontColorBottomDisabled.CGColor, nil];
	CGFloat buttonFrontGradientLocations[] = {0, 1};
	CGGradientRef buttonFrontGradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)buttonFrontGradientColors, buttonFrontGradientLocations);
	NSArray* indicatorGradientColors = [NSArray arrayWithObjects: 
										(id)indicatorColorTopDisabled.CGColor, 
										(id)[UIColor colorWithRed: 0.34 green: 0.49 blue: 0.86 alpha: 0.5].CGColor, 
										(id)indicatorColorBottomDisabled.CGColor, nil];
	CGFloat indicatorGradientLocations[] = {0, 0.3, 1};
	CGGradientRef indicatorGradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)indicatorGradientColors, indicatorGradientLocations);
	
	//// Shadow Declarations
	CGColorRef lightShadow = lightShadowColorDisabled.CGColor;
	CGSize lightShadowOffset = CGSizeMake(0, 1);
	CGFloat lightShadowBlurRadius = 0;
	CGColorRef darkShadow = darkShadowColorDisabled.CGColor;
	CGSize darkShadowOffset = CGSizeMake(0, 1);
	CGFloat darkShadowBlurRadius = 0;
	
	
	//// Button Front Rectangle Drawing
	UIBezierPath* buttonFrontRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 0.5, self.frame.size.width-1, 24) cornerRadius: 12];
	CGContextSaveGState(context);
	[buttonFrontRectanglePath addClip];
	CGContextDrawLinearGradient(context, buttonFrontGradient, CGPointMake(15, 0.5), CGPointMake(15, 24.5), 0);
	CGContextRestoreGState(context);
	
	
	
	CGFloat offset = self.frame.size.width - 30;
	//// Indicator Drawing
	UIBezierPath* indicatorPath = [UIBezierPath bezierPath];
	[indicatorPath moveToPoint: CGPointMake(24 + offset, 12.75)];
	[indicatorPath addLineToPoint: CGPointMake(17.25 + offset, 20)];
	[indicatorPath addLineToPoint: CGPointMake(15 + offset, 17.75)];
	[indicatorPath addLineToPoint: CGPointMake(19.75 + offset, 13)];
	[indicatorPath addLineToPoint: CGPointMake(15 + offset, 8.25)];
	[indicatorPath addLineToPoint: CGPointMake(17.25 + offset, 6)];
	[indicatorPath addLineToPoint: CGPointMake(24 + offset, 12.75)];
	[indicatorPath closePath];
	CGContextSaveGState(context);
	CGContextSetShadowWithColor(context, lightShadowOffset, lightShadowBlurRadius, lightShadow);
	CGContextSetFillColorWithColor(context, lightShadow);
	[indicatorPath fill];
	[indicatorPath addClip];
	CGContextDrawLinearGradient(context, indicatorGradient, CGPointMake(19.5, 6), CGPointMake(19.5, 20), 0);
	
	////// Indicator Inner Shadow
	CGRect indicatorBorderRect = CGRectInset([indicatorPath bounds], -darkShadowBlurRadius, -darkShadowBlurRadius);
	indicatorBorderRect = CGRectOffset(indicatorBorderRect, -darkShadowOffset.width, -darkShadowOffset.height);
	indicatorBorderRect = CGRectInset(CGRectUnion(indicatorBorderRect, [indicatorPath bounds]), -1, -1);
	
	UIBezierPath* indicatorNegativePath = [UIBezierPath bezierPathWithRect: indicatorBorderRect];
	[indicatorNegativePath appendPath: indicatorPath];
	indicatorNegativePath.usesEvenOddFillRule = YES;
	
	CGContextSaveGState(context);
	{
		CGFloat xOffset = darkShadowOffset.width + round(indicatorBorderRect.size.width);
		CGFloat yOffset = darkShadowOffset.height;
		CGContextSetShadowWithColor(context,
									CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
									darkShadowBlurRadius,
									darkShadow);
		
		[indicatorPath addClip];
		CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(indicatorBorderRect.size.width), 0);
		[indicatorNegativePath applyTransform: transform];
		[[UIColor grayColor] setFill];
		[indicatorNegativePath fill];
	}
	CGContextRestoreGState(context);
	
	CGContextRestoreGState(context);
	
	
	CGFloat width = self.frame.size.width - 30;
	//// Button Edge Drawing
	UIBezierPath* buttonEdgePath = [UIBezierPath bezierPath];
	[buttonEdgePath moveToPoint: CGPointMake(17.5 + width, 0.5)];
	[buttonEdgePath addLineToPoint: CGPointMake(12.5, 0.5)];
	[buttonEdgePath addCurveToPoint: CGPointMake(0.5, 12.5) controlPoint1: CGPointMake(5.87, 0.5) controlPoint2: CGPointMake(0.5, 5.87)];
	[buttonEdgePath addCurveToPoint: CGPointMake(12.5, 24.5) controlPoint1: CGPointMake(0.5, 19.13) controlPoint2: CGPointMake(5.87, 24.5)];
	[buttonEdgePath addLineToPoint: CGPointMake(17.5 + width, 24.5)];
	[buttonEdgePath addCurveToPoint: CGPointMake(29.5 + width, 12.5) controlPoint1: CGPointMake(24.13 + width, 24.5) controlPoint2: CGPointMake(29.5 + width, 19.13)];
	[buttonEdgePath addCurveToPoint: CGPointMake(17.5 + width, 0.5) controlPoint1: CGPointMake(29.5 + width, 5.87) controlPoint2: CGPointMake(24.13 + width, 0.5)];
	[buttonEdgePath closePath];
	[buttonEdgePath moveToPoint: CGPointMake(30 + width, 12.5)];
	[buttonEdgePath addCurveToPoint: CGPointMake(17.5 + width, 25) controlPoint1: CGPointMake(30 + width, 19.4) controlPoint2: CGPointMake(24.4 + width, 25)];
	[buttonEdgePath addLineToPoint: CGPointMake(12.5, 25)];
	[buttonEdgePath addCurveToPoint: CGPointMake(0, 12.5) controlPoint1: CGPointMake(5.6, 25) controlPoint2: CGPointMake(-0, 19.4)];
	[buttonEdgePath addCurveToPoint: CGPointMake(12.5, -0) controlPoint1: CGPointMake(0, 5.6) controlPoint2: CGPointMake(5.6, -0)];
	[buttonEdgePath addLineToPoint: CGPointMake(17.5 + width, -0)];
	[buttonEdgePath addCurveToPoint: CGPointMake(30 + width, 12.5) controlPoint1: CGPointMake(24.4 + width, -0) controlPoint2: CGPointMake(30 + width, 5.6)];
	[buttonEdgePath closePath];
	CGContextSaveGState(context);
	[buttonEdgePath addClip];
	CGContextDrawLinearGradient(context, buttonBackgroundGradient, CGPointMake(15, -0), CGPointMake(15, 25), 0);
	CGContextRestoreGState(context);
	
	
	//// Cleanup
	CGGradientRelease(buttonBackgroundGradient);
	CGGradientRelease(buttonFrontGradient);
	CGGradientRelease(indicatorGradient);
	CGColorSpaceRelease(colorSpace);
}

@end
