//
//  YBGameController.m
//  notTouchWhiteBlock
//
//  Created by methodname on 15/6/22.
//  Copyright (c) 2015年 tangmingming. All rights reserved.
//

#import "YBGameController.h"
#import "GameOverController.h"

@interface YBGameController()
//移动计时器
@property (nonatomic,strong)NSTimer *timermove;
//等级
@property (nonatomic,assign)int timelive;
//分数
@property (nonatomic,assign)int numCount;
//分数lable
@property (nonatomic,strong)UILabel *lableNum;
//记录创建的黑色方块数
@property (nonatomic,assign)NSInteger blockCount;
//记录当前点击到哪个方块
@property (nonatomic,assign)NSInteger blockNum;
@end

@implementation YBGameController




#pragma mark -【视图加载】------------------------------------------
-(void)viewDidLoad{
    [super viewDidLoad];
    _blockNum=0;
    _blockCount=0;
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    _timelive=3;
    _numCount=0;
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self createBlock];
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

#pragma mark -创建初始方块
-(void)createBlock{
    //分数
    _lableNum=[[UILabel alloc]initWithFrame:CGRectMake(260, 25, 50, 15)];
    [_lableNum setFont:[UIFont fontWithName:@"Marker Felt" size:20]];
    [_lableNum setTextColor:[UIColor redColor]];
    _lableNum.text=[NSString stringWithFormat:@"%i",_numCount];
    [_lableNum.layer setZPosition:99];
    [_lableNum setHidden:YES];
    [self.view addSubview:_lableNum];
    //创建初始方块
    int x=self.view.frame.size.width/4;
    int y=self.view.frame.size.height/4;
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(1, y*3, x-1, y-1)];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(x+1, y*3, x-1, y-1)];
    [btn2 setBackgroundColor:[UIColor whiteColor]];
    //开始游戏的方块
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(x*2+1, y*3, x-1, y-1)];
    [btn3 setBackgroundColor:[UIColor blackColor]];
    [btn3 setTitleColor:[UIColor whiteColor] forState:0];
    [btn3 setTitle:@"GO" forState:0];
    [btn3 addTarget:self action:@selector(startGame:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTag:(_blockCount++)];
    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(x*3+1, y*3, x-1, y-1)];
    [btn4 setBackgroundColor:[UIColor whiteColor]];
    [btn1 setTag:0];
    [btn2 setTag:0];
    [btn4 setTag:0];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    
    for (int i=2; i>=0; i--) {
        int value=rand()%2;
        for (int j=0; j<4; j++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(j*x+1, y*i, x-1, y-1)];
            if (value==j||value+2==j) {
                [btn setBackgroundColor:[UIColor blackColor]];
                [btn setTag:(_blockCount++)];
            }else{
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn setTag:0];
            }
            [btn addTarget:self action:@selector(blockTouch:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:btn];
        }
    }
}

#pragma mark -随机创建方块
-(void)rundBlock{
    int x=self.view.frame.size.width/4;
    int y=self.view.frame.size.height/4;
    int value=rand()%2;
    for (int i=0; i<4; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(i*x+1, -y, x-1, y-1)];;
        if (value==i||value+2==i) {
            //黑色
            [btn setBackgroundColor:[UIColor blackColor]];
            [btn setTag:(_blockCount++)];
        }else{
            //白色
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTag:0];
        }
        [btn addTarget:self action:@selector(blockTouch:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    [self deleteBlock];
}

#pragma mark -移动方块
-(void)moveBlock{
    //NSArray * arr = self.view.subviews;
    for (int i=0; i<self.view.subviews.count; i++) {
        if ([self.view.subviews[i] isKindOfClass:[UIButton class]]) {
            UIButton *btn=(UIButton *)self.view.subviews[i];
            CGRect ct=btn.frame;
            ct.origin.y=ct.origin.y+0.5*_timelive;
            [btn setFrame:ct];
        }
    }
    BOOL isCreateBlock = YES;
    for (int i=0; i<self.view.subviews.count; i++) {
        //如果还有方块在地图外面
        UIButton *btn=(UIButton *)self.view.subviews[i];
        if (btn.frame.origin.y<(float)_timelive*0.1) {
            isCreateBlock = NO;
            break;
        }
    }
    //如果没有方块的Y坐标在view 的外面，创建一组方块,并将已经移到到屏幕外的方块删除
    if (isCreateBlock) {
        [self rundBlock];
        [self deleteBlock];
    }
    
}

#pragma mark -删除方块
-(void)deleteBlock{
    int y=self.view.frame.size.height;
    for (int i=0; i<self.view.subviews.count; i++) {
        if ([self.view.subviews[i] isKindOfClass:[UIButton class]]) {
            UIButton *btn=(UIButton *)self.view.subviews[i];
            if (btn.frame.origin.y>900) {
                [btn removeFromSuperview];
            }
            if (btn.frame.origin.y>(y-y/4)&&btn.tag>0) {
                [btn setBackgroundColor:[UIColor redColor]];
                [self gameOver];
                break;
            }
        }
        
    }
}

#pragma mark -方块点击
-(void)blockTouch:(UIButton *)btn{
    if(btn.tag==0){
        [btn setBackgroundColor:[UIColor redColor]];
        [self gameOver];
        
    }//当前点击的方块tag值和累加的点击数相同
    else{
        [btn setBackgroundColor:[UIColor greenColor]];
        [btn setTag:-1];
        _numCount+=1;
        _blockNum++;
        _lableNum.text=[NSString stringWithFormat:@"%i",_numCount];
        [self setLive];
    }
}

#pragma mark -等级修改
-(void)setLive{
    _timelive = _numCount/10+5;
}

#pragma mark -游戏结束
-(void)gameOver{
    [_timermove invalidate];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self.view setCenter:CGPointMake(self.view.center.x, self.view.center.y-50)];
    } completion:^(BOOL finished) {
        [self.view setCenter:CGPointMake(self.view.center.x, self.view.center.y+50)];
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"seguaYBOver" sender:nil];
        });
    });
    
}

#pragma mark -开始游戏
-(void)startGame:(UIButton *)btn{
    _blockCount = 4;
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTag:-1];
    //计时器初始化
    _timermove =[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveBlock) userInfo:nil repeats:YES];
    [_timermove fire];
    [_lableNum setHidden:NO];
    
}

#pragma mark -页面切换
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    GameOverController *over = (GameOverController *)segue.destinationViewController;
    [over setDelegate:self];
    //获取文档路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取文件路径
    NSString *path =[NSString  stringWithFormat:@"%@/%@",paths[0], @"saveYB.rtf"];
    //创建文件管理对象
    NSFileManager *nfm  = [NSFileManager defaultManager];
    //读取文件
    NSData *data1= [nfm contentsAtPath:path];
    NSString *str;
    if(data1==nil){
        str=@"0";
    }else{
        str=[[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    }
    
    over.maxNumleStr = [NSString stringWithFormat:@"最高分：%@",str];
    over.numStr=[NSString stringWithFormat:@"%i",_numCount];
    over.titleStr = @"摇摆";
    if (_numCount>str.integerValue) {
        //创建文件管理对象
        NSData *data = [[NSData alloc] init];//也可以通过简单方式赋值。
        data = [[NSString stringWithFormat:@"%d",_numCount] dataUsingEncoding:NSUTF8StringEncoding];//把内容与data联系起来，并且规定好编码格式为utf8
        //写入文件
        [nfm createFileAtPath:path contents:data attributes:nil];
    }
    
}

#pragma mark -实现代理方法
-(void)GameDoingWithString:(NSString *)str{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    if ([str isEqualToString:@"reset"]) {
        //重新开始游戏
        [self viewDidLoad];
    }else if([str isEqualToString:@"Home"]){
        //回到主页
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
