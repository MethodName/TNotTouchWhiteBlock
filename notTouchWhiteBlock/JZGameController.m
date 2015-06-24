//
//  JZGameController.m
//  notTouchWhiteBlock
//
//  Created by methodname on 15/6/23.
//  Copyright (c) 2015年 tangmingming. All rights reserved.
//

#import "JZGameController.h"

@implementation JZGameController

-(void)viewDidLoad{
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeDown=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(goBack)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

-(void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
