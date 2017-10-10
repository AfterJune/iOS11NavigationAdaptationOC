
//  UIView+Tracker.m
//  iOS11AdaptationOC
//
//  Created by JL on 2017/9/28.
//  Copyright © 2017年 JL. All rights reserved.
//



#import "UIView+Tracker.h"
#import "NSObject+Tracker.h"
static CGFloat margin = 5.0;
static CGFloat space = 1.0;
typedef NS_ENUM(NSInteger ,LayoutGuideType){
    BackButtonGuide,
    LeadingBarGuide,
    TitleView,
    TrailingBarGuide,
    UIViewLayoutMarginsGuide,
    LayoutGuideUnknown
};

@implementation UIView (Tracker)

+ (void)load
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]  < 11) { return; }
    [self swizzleInstanceMethodWithOriginSel:@selector(layoutSubviews) swizzledSel:@selector(JLLayoutSubviews)];

    
}

- (void)JLLayoutSubviews
{
    [self JLLayoutSubviews];
    NSString *classString = NSStringFromClass([self class]);
    if ([classString isEqualToString:@"_UITAMICAdaptorView"])
    {
        UIView *view = self;
        while (![view isKindOfClass:UINavigationBar.class] && view.superview) {
            view = [view superview];
            if ([view isKindOfClass:UIStackView.class] && view.superview) {
                // change space
                for (UIView *subView in ((UIStackView *)view).subviews) {
                    NSString *classStr = NSStringFromClass(subView.class);
                    if (![classStr isEqualToString:@"_UITAMICAdaptorView"]) {
                        
                        NSLayoutConstraint *c = [NSLayoutConstraint constraintWithItem:subView
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:nil
                                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                                            multiplier:1.0
                                                                              constant:space];
                        [subView.superview addConstraint:c];
                    }
                }
                // change margin
                for (UILayoutGuide *layoutGuide in view.superview.layoutGuides) {
                    NSLog(@"%@",layoutGuide);
                    if ([self layoutGuideType:layoutGuide] == LeadingBarGuide) {
                        NSLayoutConstraint *newCons = [NSLayoutConstraint constraintWithItem:layoutGuide
                                                                             attribute:NSLayoutAttributeLeading
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:view.superview
                                                                             attribute:NSLayoutAttributeLeading
                                                                            multiplier:1.0
                                                                              constant:margin];

                        [view.superview addConstraint:newCons];
                    }
                    if ([self layoutGuideType:layoutGuide] == TrailingBarGuide) {
                        NSLayoutConstraint *newCons = [NSLayoutConstraint constraintWithItem:layoutGuide
                                                                                   attribute:NSLayoutAttributeTrailing
                                                                                   relatedBy:NSLayoutRelationEqual
                                                                                      toItem:view.superview
                                                                                   attribute:NSLayoutAttributeTrailing
                                                                                  multiplier:1.0
                                                                                    constant:-margin];
                        
                        [view.superview addConstraint:newCons];
                    }
                }
                break;
            }
        }
        
    }
    
}

- (LayoutGuideType)layoutGuideType:(UILayoutGuide *)layoutGuide
{
    NSString *layoutGuideDesc = layoutGuide.identifier;
    /**
     BackButtonGuide,
     LeadingBarGuide,
     TitleView,
     TrailingBarGuide,
     UIViewLayoutMarginsGuide
     */
    if ([layoutGuideDesc rangeOfString:@"BackButtonGuide"].location != NSNotFound) {
        return BackButtonGuide;
    }
    if ([layoutGuideDesc rangeOfString:@"LeadingBarGuide"].location != NSNotFound) {
        return LeadingBarGuide;
    }
    if ([layoutGuideDesc rangeOfString:@"TitleView"].location != NSNotFound) {
        return TitleView;
    }
    if ([layoutGuideDesc rangeOfString:@"TrailingBarGuide"].location != NSNotFound) {
        return TrailingBarGuide;
    }
    if ([layoutGuideDesc rangeOfString:@"UIViewLayoutMarginsGuide"].location != NSNotFound) {
        return UIViewLayoutMarginsGuide;
    }
    return LayoutGuideUnknown;
    
}

@end
