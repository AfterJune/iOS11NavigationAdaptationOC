//
//  ViewController.m
//  iOS11AdaptationOC
//
//  Created by 卢子飞 on 2017/9/27.
//  Copyright © 2017年 卢子飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"左边按钮" forState:UIControlStateNormal];
    leftButton.backgroundColor = [UIColor greenColor];
    leftButton.frame = CGRectMake(0, 0, 30, 50);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIButton *leftButton_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton_1 setTitle:@"左边按钮" forState:UIControlStateNormal];
    leftButton_1.backgroundColor = [UIColor greenColor];
    leftButton_1.frame = CGRectMake(0, 0, 30, 50);
    UIBarButtonItem *leftItem_1 = [[UIBarButtonItem alloc] initWithCustomView:leftButton_1];
    self.navigationItem.leftBarButtonItems = @[leftItem,leftItem_1];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"右边按钮" forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor greenColor];
    rightButton.frame = CGRectMake(0, 0, 30, 50);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIButton *rightButton_1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton_1 setTitle:@"右边按钮" forState:UIControlStateNormal];
    rightButton_1.backgroundColor = [UIColor greenColor];
    rightButton_1.frame = CGRectMake(0, 0, 30, 50);
    UIBarButtonItem *rightItem_1 = [[UIBarButtonItem alloc] initWithCustomView:rightButton_1];
    self.navigationItem.rightBarButtonItems = @[rightItem,rightItem_1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
