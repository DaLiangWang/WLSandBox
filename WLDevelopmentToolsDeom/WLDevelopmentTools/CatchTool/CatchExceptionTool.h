//
//  CatchExceptionTool.h
//  bug
//
//  Created by 王亮 on 2018/7/20.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatchExceptionTool : NSObject

+ (instancetype)shareInstance;
//读取plist数据
- (NSArray*)readExceptionInfoFromLocal;
//初始化工具
- (void)installUncaughtExceptionHandler;
//清楚所有
- (void)clearAllLog;
//移除指定数据
- (void)removeExceptionItemIndex:(NSUInteger)index;
@end

