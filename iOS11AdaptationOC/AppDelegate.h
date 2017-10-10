//
//  AppDelegate.h
//  iOS11AdaptationOC
//
//  Created by 卢子飞 on 2017/9/27.
//  Copyright © 2017年 卢子飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

