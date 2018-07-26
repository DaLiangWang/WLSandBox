//
//  WLSingleCase.h
//  bug
//
//  Created by 王亮 on 2018/7/26.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WLSingleCase : NSObject
+ (instancetype)shareInstance;

/** 是否显示触摸轨迹 默认关闭 */
@property(nonatomic,assign) BOOL isShowTouchTagView;
@property(nonatomic,strong) UIView *showTouchTagView;
@end
