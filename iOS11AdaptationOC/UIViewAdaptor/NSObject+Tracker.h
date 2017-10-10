//
//  NSObject+Tracker.h
//  iOS11AdaptationOC
//
//  Created by 卢子飞 on 2017/9/27.
//  Copyright © 2017年 卢子飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Tracker)
+ (void)swizzleInstanceMethodWithOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel;
@end
