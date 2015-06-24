//
//  GameOverController.m
//  notTouchWhiteBlock
//
//  Created by tangmingming on 15-6-18.
//  Copyright (c) 2015年 tangmingming. All rights reserved.
//

#import "GameOverController.h"

@interface GameOverController()


@end


@implementation GameOverController

-(void)viewDidLoad{
    [super viewDidLoad];
    //隐藏状态栏
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    [_lableNum setFont:[UIFont fontWithName:@"Marker Felt" size:35]];
    
    _lableNum.text = _numStr;
    _maxNum.text = _maxNumleStr;
    _titleLable.text = _titleStr;
    
}



#pragma mark -重新开始游戏
- (IBAction)resetBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [_delegate GameDoingWithString:@"reset"];
}


#pragma mark -回到主页
- (IBAction)goHomeClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [_delegate GameDoingWithString:@"Home"];
}



- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}













@end
