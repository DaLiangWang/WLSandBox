//
//  WLGroupDebugFileModel.h
//  bug
//
//  Created by 王亮 on 2018/7/20.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    WLGroupDebugFileTouchSchemePath,//路径
    WLGroupDebugFileTouchSchemeFile,//文件
    WLGroupDebugFileTouchSchemeNona,//其他
} WLGroupDebugFileTouchScheme;
@interface WLGroupDebugFileModel : NSObject
/** 完整路径 */
@property(nonatomic,strong) NSString *filePath;
/** 文件名 */
@property(nonatomic,strong) NSString *fileName;
/** 文件别名 */
@property(nonatomic,strong) NSString *fileOtherName;
/** 类型 */
@property(nonatomic,assign) WLGroupDebugFileTouchScheme groupDebugFileTouchScheme;
/** 文件信息 */
@property(nonatomic,strong) NSString *fileDesc;

/** 文件 */
@property(nonatomic,strong) id data;
/** 文件大小 */
@property(nonatomic,strong) NSString *dataSize;
@end
