//
//  UINavigationItem+Tracker.m
//  iOS11AdaptationOC
//
//  Created by 卢子飞 on 2017/9/27.
//  Copyright © 2017年 卢子飞. All rights reserved.
//

#import "UINavigationItem+Tracker.h"
#import <objc/runtime.h>
#import "NSObject+Tracker.h"

static CGFloat margin = 5.0;
static CGFloat space = 1.0;

typedef NS_ENUM(NSInteger, BufferItemSide){
    BufferItemSideLeft,
    BufferItemSideRight
};
@interface BufferItem :UIView
@property (nonatomic,assign)BufferItemSide itemSide;
@property (nonatomic, assign)BOOL reLayouted;
@end

@implementation BufferItem
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.reLayouted || [[[UIDevice currentDevice] systemVersion] floatValue]  < 11) return;
    UIView *view = self;
    while (![view isKindOfClass:UINavigationBar.class] && view.superview) {
        view = [view superview];
        if ([view isKindOfClass:UIStackView.class] && view.superview) {
            // 修改space
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
            if (self.itemSide == BufferItemSideLeft) {
                for (NSLayoutConstraint *constraint in view.superview.constraints) {
                    if (([constraint.firstItem isKindOfClass:UILayoutGuide.class] &&
                         constraint.firstAttribute == NSLayoutAttributeTrailing)) {
                        [view.superview removeConstraint:constraint];
                    }
                }
                [view.superview addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeLeading
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:view.superview
                                                                           attribute:NSLayoutAttributeLeading
                                                                          multiplier:1.0
                                                                            constant:margin]];
                self.reLayouted = YES;
            } else if (self.itemSide == BufferItemSideRight) {
                for (NSLayoutConstraint *constraint in view.superview.constraints) {
                    if (([constraint.firstItem isKindOfClass:UILayoutGuide.class] &&
                         constraint.firstAttribute == NSLayoutAttributeLeading)) {
                        [view.superview removeConstraint:constraint];
                    }
                }
                [view.superview addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeTrailing
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:view.superview
                                                                           attribute:NSLayoutAttributeTrailing
                                                                          multiplier:1.0
                                                                            constant:margin]];
                self.reLayouted = YES;
            }
            break;
        }
    }
}
@end


@implementation UINavigationItem (Tracker)

+(void)load
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]  < 11) {
        return;
    }
    [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItem:) swizzledSel:@selector(JLSetLeftItem:)];
    [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItems:) swizzledSel:@selector(JLSetLeftItems:)];
    [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItem:) swizzledSel:@selector(JLSetRightItem:)];
    [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItems:) swizzledSel:@selector(JLSetRightItems:)];
}

- (void)JLSetLeftItem:(UIBarButtonItem *)item
{
    if (item.customView) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
            UIView *customView = item.customView;
            BufferItem *bufferView = [[BufferItem alloc]initWithFrame:customView.bounds];
            [bufferView addSubview:customView];
            customView.center = bufferView.center;
            [bufferView setItemSide:BufferItemSideLeft];
            [self setLeftBarButtonItems:nil];
            [self JLSetLeftItem:[[UIBarButtonItem alloc]initWithCustomView:bufferView]];
        }else {
            [self JLSetLeftItem:nil];
            [self setLeftBarButtonItems:@[[self fixedSpaceWithWidth:-20], item]];
        }
    }else {
        [self setLeftBarButtonItems:nil];
        [self JLSetLeftItem:item];
    }
}
- (void)JLSetRightItem:(UIBarButtonItem*)item
{
    if (item.customView) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
            UIView *customView = item.customView;
            BufferItem *bufferView = [[BufferItem alloc]initWithFrame:customView.bounds];
            [bufferView addSubview:customView];
            customView.center = bufferView.center;
            [bufferView setItemSide:BufferItemSideLeft];
            [self setRightBarButtonItems:nil];
            [self JLSetRightItem:[[UIBarButtonItem alloc]initWithCustomView:bufferView]];
        }else {
            [self JLSetRightItem:nil];
            [self setRightBarButtonItems:@[[self fixedSpaceWithWidth:-20], item]];
        }
    }else {
        [self setRightBarButtonItems:nil];
        [self JLSetRightItem:item];
    }
}
- (void)JLSetLeftItems:(NSArray<UIBarButtonItem *>*)items
{
    NSMutableArray *barItems = [NSMutableArray array];
    for (UIBarButtonItem *item in items) {
        if (item.customView) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
                UIView *customView = item.customView;
                BufferItem *bufferView = [[BufferItem alloc]initWithFrame:customView.bounds];
                [bufferView addSubview:customView];
                customView.center = bufferView.center;
                [bufferView setItemSide:BufferItemSideLeft];
                [barItems addObject:[[UIBarButtonItem alloc]initWithCustomView:bufferView]];
            }else {
                [barItems addObject:item];
            }
        }else {
            [barItems addObject:item];
        }
    }
//    [self setLeftBarButtonItems:nil];
    [self JLSetLeftItems:barItems];
    
}
- (void)JLSetRightItems:(NSArray<UIBarButtonItem *>*)items
{
    NSMutableArray *barItems = [NSMutableArray array];
    for (UIBarButtonItem *item in items) {
        if (item.customView) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
                UIView *customView = item.customView;
                BufferItem *bufferView = [[BufferItem alloc]initWithFrame:customView.bounds];
                [bufferView addSubview:customView];
                customView.center = bufferView.center;
                [bufferView setItemSide:BufferItemSideLeft];
                [barItems addObject:[[UIBarButtonItem alloc]initWithCustomView:bufferView]];
            }else {
                [barItems addObject:item];
            }
        }else {
            [barItems addObject:item];
        }
    }
//    [self setRightBarButtonItems:nil];
    [self JLSetRightItems:barItems];
}

-(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}
@end
