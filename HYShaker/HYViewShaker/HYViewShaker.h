//
//  HYViewShaker.h
//  HYShaker
//
//  Created by heyang on 15/9/10.
//  Copyright (c) 2015年 com.scxingdun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface HYViewShaker : NSObject

/** 初始化(用于单个视图抖动)*/
- (instancetype)initWithView:(UIView *)view;

/** 初始化(用于多个视图抖动)*/
- (instancetype)initWithViewsArray:(NSArray *)viewsArray;

/** 执行抖动*/
- (void)shake;

/** 抖动事件及动画执行完毕回调方法*/
- (void)shakeWithDuration:(NSTimeInterval)duration completion:(void (^)())completion;

@end
