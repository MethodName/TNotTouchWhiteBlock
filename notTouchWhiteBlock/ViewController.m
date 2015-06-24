//
//  ViewController.m
//  notTouchWhiteBlock
//
//  Created by tangmingming on 15-6-16.
//  Copyright (c) 2015年 tangmingming. All rights reserved.
//

#import "ViewController.h"
#import "GameController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }

}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

#pragma mark -弹出游戏试图
- (IBAction)btnJDStart:(UIButton *)sender {
    [self performSegueWithIdentifier:@"seguaJD" sender:sender];
}
- (IBAction)btnJJStart:(UIButton *)sender {
     [self performSegueWithIdentifier:@"seguaJJ" sender:sender];
}
- (IBAction)btnJZStart:(UIButton *)sender {
    [self performSegueWithIdentifier:@"seguaJZ" sender:sender];
}
- (IBAction)btnYBStart:(UIButton *)sender {
    [self performSegueWithIdentifier:@"seguaYB" sender:sender];
}




#pragma mark -页面切换
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //GameController *game = (GameController *)segue.destinationViewController;
    //[game viewDidLoad];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
