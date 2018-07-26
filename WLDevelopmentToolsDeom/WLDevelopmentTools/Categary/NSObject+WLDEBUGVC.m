//
//  WLGroupDebugView+WLVC.m
//  bug
//
//  Created by 王亮 on 2018/7/20.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "NSObject+WLDEBUGVC.h"

@implementation NSObject (WLDEBUGVC)
- (UIViewController *)topDebugViewController_wl {
    UIViewController *resultVC;
    resultVC = [self _topDebugViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topDebugViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
- (UIViewController *)_topDebugViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topDebugViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topDebugViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}






@end
