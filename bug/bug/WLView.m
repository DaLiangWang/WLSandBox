//
//  WLView.m
//  bug
//
//  Created by 王亮 on 2018/7/26.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "WLView.h"
#import "WLDEBUGViewController.h"

@implementation WLView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"123412341234");
}

@end
