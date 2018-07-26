//
//  CatchExceptionModel.h
//  bug
//
//  Created by 王亮 on 2018/7/20.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatchExceptionModel : NSObject<NSCopying>
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *reason;
@property(copy,nonatomic)NSString *time;
@property(copy,nonatomic)NSArray *cellStack;

@end
