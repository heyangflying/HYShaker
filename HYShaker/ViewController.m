//
//  ViewController.m
//  HYShaker
//
//  Created by heyang on 15/9/10.
//  Copyright (c) 2015年 com.scxingdun. All rights reserved.
//

#import "HYViewShaker.h"
#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) HYViewShaker * hyViewShaker;
@end

@implementation ViewController



- (IBAction)userLoginAction:(UIButton *)sender {
    
    
    /** 该方法没有动画执行完毕的block回调*/
    
    //  [_hyViewShaker shake];
    
    
    /** 带动画执行完毕的block回调,可以执行一些自定义操作(登录失败获成功处理相关逻辑事件)*/
   
    [_hyViewShaker shakeWithDuration:.6 completion:^{
      
        [[[UIAlertView alloc] initWithTitle:@"YounG"
                                    message:@"抖动动画执行完毕回调"
                                   delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] show];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    /** 创建数组用于存储需要抖动的视图*/
    NSMutableArray *viewsArray = [NSMutableArray array];
    
    /** 遍历寻找需要抖动的视图并装入数组中*/
    for (UIView *subView in self.view.subviews) {
        
        if(![subView isKindOfClass:[UIButton class]]){
            [viewsArray addObject:subView];
        }
    }
    
    /** Creat 传入需要抖动的视图数组*/
    _hyViewShaker =  [[HYViewShaker alloc] initWithViewsArray:viewsArray];

}

@end
