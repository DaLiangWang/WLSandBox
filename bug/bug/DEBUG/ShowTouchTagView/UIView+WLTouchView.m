//
//  UIView+WLTouchView.m
//  bug
//
//  Created by 王亮 on 2018/7/26.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "UIView+WLTouchView.h"
#import <objc/runtime.h>
#import "WLSingleCase.h"
#import "WLDEBUGHeader.h"

@implementation UIView (WLTouchView) 

//static char *showViewKey = "showViewKey";

+(void)load{
    
#ifdef DEBUG
    NSString *className=NSStringFromClass(self.class);
    NSLog(@"classname:%@",className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        
//        SEL originalSelector=@selector(hitTest:withEvent:);
//        SEL swizzledSelector=@selector(wl_hitTest:withEvent:);
//        [UIView originalSelector:originalSelector swizzledSelector:swizzledSelector];
        
        
        SEL originalSelector=@selector(touchesBegan:withEvent:);
        SEL swizzledSelector=@selector(wl_touchesBegan:withEvent:);
        [UIView originalSelector:originalSelector swizzledSelector:swizzledSelector];

        SEL originalSelector1=@selector(touchesMoved:withEvent:);
        SEL swizzledSelector1=@selector(wl_touchesMoved:withEvent:);
        [UIView originalSelector:originalSelector1 swizzledSelector:swizzledSelector1];

        SEL originalSelector2=@selector(touchesEnded:withEvent:);
        SEL swizzledSelector2=@selector(wl_touchesEnded:withEvent:);
        [UIView originalSelector:originalSelector2 swizzledSelector:swizzledSelector2];
        
    });
#endif
}
+(void)originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    Class class=[self class];

    Method originalMethod = class_getInstanceMethod(class,originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class,swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if(didAddMethod){
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod,swizzledMethod);
    }
}



//-(void)setShowView_wl:(UIView *)showView_wl{
//    objc_setAssociatedObject(self, showViewKey, showView_wl, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//-(UIView *)showView_wl{
//    UIView *_showView_wl = objc_getAssociatedObject(self, showViewKey);
//    if (!_showView_wl) {
//        _showView_wl = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
//        _showView_wl.backgroundColor = [UIColor yellowColor];
//    }
//    return _showView_wl;
//}


-(void)wl_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([WLSingleCase shareInstance].isShowTouchTagView) {
        [keyWindows_wl addSubview:[WLSingleCase shareInstance].showTouchTagView];
        [WLSingleCase shareInstance].showTouchTagView.alpha = 1;
        [WLSingleCase shareInstance].showTouchTagView.center = [self getEcentOfPoint:event];
    }
//    NSLog(@"点击:%@ - view:%@",NSStringFromCGPoint([self getEcentOfPoint:event]),[self getEcentOfView:event]);
    [super touchesBegan:touches withEvent:event];
}
-(void)wl_touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([WLSingleCase shareInstance].isShowTouchTagView) {
        [keyWindows_wl addSubview:[WLSingleCase shareInstance].showTouchTagView];
        [WLSingleCase shareInstance].showTouchTagView.alpha = 1;
        [WLSingleCase shareInstance].showTouchTagView.center = [self getEcentOfPoint:event];
    }
//    NSLog(@"拖动:%@ - view:%@",NSStringFromCGPoint([self getEcentOfPoint:event]),[self getEcentOfView:event]);
    [super touchesMoved:touches withEvent:event];
}
-(void)wl_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([WLSingleCase shareInstance].isShowTouchTagView) {
        [[WLSingleCase shareInstance].showTouchTagView removeFromSuperview];
        [WLSingleCase shareInstance].showTouchTagView.alpha = 0;
        [WLSingleCase shareInstance].showTouchTagView.center = CGPointMake(0, 0);
    }
//    NSLog(@"结束:%@ - view:%@",NSStringFromCGPoint([self getEcentOfPoint:event]),[self getEcentOfView:event]);
    [super touchesEnded:touches withEvent:event];
}

/** 获取点坐标 相对于windows */
-(CGPoint)getEcentOfPoint:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[UIApplication sharedApplication].keyWindow]; //返回触摸点在视图中的当前坐标
    return point;
}
/** 获取试图 */
-(UIView *)getEcentOfView:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    return [touch view];
}

@end
