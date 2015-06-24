//
//  AnimeScale.m
//  notTouchWhiteBlock
//
//  Created by methodname on 15/6/22.
//  Copyright (c) 2015年 tangmingming. All rights reserved.
//

#import "AnimeScale.h"
#import <UIKit/UIKit.h>

@implementation AnimeScale


#pragma mark -缩放动画
-(void)scaleAnime:(UIView *)view FromValue:(float)fromVale ToValue:(float)toVlaue Duration:(float)duration Autoreverse:(BOOL)autoreverses RepeatCount:(float)repeatCount{
    CABasicAnimation *basicAnime=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [basicAnime setFromValue:[NSNumber numberWithFloat:fromVale]];
    [basicAnime setToValue:[NSNumber numberWithFloat:toVlaue]];
    [basicAnime setDuration:duration];
    [basicAnime setAutoreverses:autoreverses];
    [basicAnime setRepeatCount:repeatCount];
    [view.layer addAnimation:basicAnime forKey:@"scaleAnime"];
}

#pragma mark -缩放动画透明
-(void)scaleOpacityAnime:(UIView *)view FromValue:(float)fromVale ToValue:(float)toVlaue Duration:(float)duration Autoreverse:(BOOL)autoreverses RepeatCount:(float)repeatCount{
    CABasicAnimation *basicAnime=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [basicAnime setFromValue:[NSNumber numberWithFloat:fromVale]];
    [basicAnime setToValue:[NSNumber numberWithFloat:toVlaue]];
    [basicAnime setDuration:duration];
    [basicAnime setAutoreverses:autoreverses];
    [basicAnime setRepeatCount:repeatCount];
    [view.layer addAnimation:basicAnime forKey:@"scaleAnime"];
    
    CABasicAnimation *opacityAnime=[CABasicAnimation animationWithKeyPath:@"opacity"];
    [opacityAnime setFromValue:[NSNumber numberWithFloat:0.2]];
    [opacityAnime setToValue:[NSNumber numberWithFloat:1.0]];
    [opacityAnime setDuration:duration];
    [opacityAnime setAutoreverses:autoreverses];
    [opacityAnime setRepeatCount:repeatCount];
    [view.layer addAnimation:opacityAnime forKey:@"opacityAnime"];
    
}

@end
