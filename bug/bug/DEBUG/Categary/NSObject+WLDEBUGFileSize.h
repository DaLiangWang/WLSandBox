//
//  NSObject+WLDEBUGFileSize.h
//  xiacai_ios_v6
//
//  Created by 王亮 on 2018/7/23.
//  Copyright © 2018年 王振标. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WLDEBUGFileSize)
- (NSString *)fileSizeAtPath:(NSString *)filePath;
- (NSString *)folderSizeAtPath:(NSString *)folderPath;
@end
