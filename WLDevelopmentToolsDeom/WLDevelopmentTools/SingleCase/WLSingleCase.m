//
//  WLSingleCase.m
//  bug
//
//  Created by 王亮 on 2018/7/26.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "WLSingleCase.h"
#import "WLDEBUGHeader.h"
@implementation WLSingleCase
+ (instancetype)shareInstance{
    static WLSingleCase *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WLSingleCase alloc]init];
    });
    return instance;
}
-(UIView *)showTouchTagView{
    if (!_showTouchTagView) {
        _showTouchTagView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        _showTouchTagView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7f];

        _showTouchTagView.layer.masksToBounds = YES;
        _showTouchTagView.layer.cornerRadius = 10.f;
        _showTouchTagView.layer.borderWidth = 4.f;
        _showTouchTagView.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:0.5f].CGColor;
        
        _showTouchTagView.alpha = 0;
    }
    return _showTouchTagView;
}


-(void)setIsShowTouchTagView:(BOOL)isShowTouchTagView{
    _isShowTouchTagView = isShowTouchTagView;
}
@end
