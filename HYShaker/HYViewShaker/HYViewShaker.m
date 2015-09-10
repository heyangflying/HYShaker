//
//  HYViewShaker.m
//  HYShaker
//
//  Created by heyang on 15/9/10.
//  Copyright (c) 2015年 com.scxingdun. All rights reserved.
//

#import "HYViewShaker.h"


static NSTimeInterval const kHYViewShakerDefaultDuration = 0.5;
static NSString * const kHYViewShakerAnimationKey = @"kHYViewShakerAnimationKey";


@interface HYViewShaker ()
@property (nonatomic,strong) NSArray *views;
@property (nonatomic,assign) NSUInteger completedAnimationsCount;
@property (nonatomic,copy  ) void (^HyCompletionBlock)();
@end

@implementation HYViewShaker

- (instancetype)initWithView:(UIView *)view{
    return [self initWithViewsArray:@[view]];
}

- (instancetype)initWithViewsArray:(NSArray *)viewsArray{
    if(self = [super init]){
        _views = viewsArray;
    }
    return self;
}

- (void)shake{
     [self shakeWithDuration:kHYViewShakerDefaultDuration completion:nil];
}

- (void)shakeWithDuration:(NSTimeInterval)duration completion:(void (^)())completion{
    self.HyCompletionBlock = completion;
    for (UIView * view in self.views) {
        [self addShakeAnimationForView:view withDuration:duration];
    }
}

- (void)addShakeAnimationForView:(UIView *)view withDuration:(NSTimeInterval)duration {
  
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat currentTx = view.transform.tx;
    
    animation.delegate = self;
    animation.duration = duration;
    animation.values = @[ @(currentTx), @(currentTx + 10), @(currentTx-8), @(currentTx + 8), @(currentTx -5), @(currentTx + 5), @(currentTx) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:kHYViewShakerAnimationKey];
}


#pragma mark - 系统动画执行完毕协议方法

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    
    /** 统计执行了多少次动画,如果与初始化传入的视图数组个数一致说明动画执行完毕*/
    self.completedAnimationsCount += 1;
    if ( self.completedAnimationsCount >= self.views.count ) {
        self.completedAnimationsCount = 0;
        /** 回调*/
        if ( self.HyCompletionBlock ) {
            self.HyCompletionBlock();
        }
    }
}


@end
