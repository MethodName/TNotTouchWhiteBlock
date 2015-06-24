//
//  GameOverController.h
//  notTouchWhiteBlock
//
//  Created by tangmingming on 15-6-18.
//  Copyright (c) 2015年 tangmingming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewDelegate.h"

@interface GameOverController : UIViewController

//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
//分数
@property (weak, nonatomic) IBOutlet UILabel *lableNum;
//最高分
@property (weak, nonatomic) IBOutlet UILabel *maxNum;

@property (strong,nonatomic)NSString *titleStr;
@property (strong,nonatomic)NSString *numStr;
@property (strong,nonatomic)NSString *maxNumleStr;

@property (weak,nonatomic) id<GameViewDelegate> delegate;
@end
