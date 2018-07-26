//
//  NSObject+WLDEBUGFileSize.m
//  xiacai_ios_v6
//
//  Created by 王亮 on 2018/7/23.
//  Copyright © 2018年 王振标. All rights reserved.
//

#import "NSObject+WLDEBUGFileSize.h"
@implementation NSObject (WLDEBUGFileSize)

- (NSString *)fileSizeAtPath:(NSString *)filePath
{
    NSString *sizeText = @"";
    long long folderSize = [self privateFileSizeAtPath:filePath];
    if (folderSize >= pow(10, 9)) { // size >= 1GB
        sizeText = [NSString stringWithFormat:@"%.2fGB", folderSize / pow(10, 9)];
    } else if (folderSize >= pow(10, 6)) { // 1GB > size >= 1MB
        sizeText = [NSString stringWithFormat:@"%.2fMB", folderSize / pow(10, 6)];
    } else if (folderSize >= pow(10, 3)) { // 1MB > size >= 1KB
        sizeText = [NSString stringWithFormat:@"%.2fKB", folderSize / pow(10, 3)];
    } else { // 1KB > size
        sizeText = [NSString stringWithFormat:@"%lldB", folderSize];
    }
    return sizeText;
}
- (NSString *)folderSizeAtPath:(NSString *)folderPath
{
    NSString *sizeText = @"";
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self privateFileSizeAtPath:fileAbsolutePath];
    }
    if (folderSize >= pow(10, 9)) { // size >= 1GB
        sizeText = [NSString stringWithFormat:@"%.2fGB", folderSize / pow(10, 9)];
    } else if (folderSize >= pow(10, 6)) { // 1GB > size >= 1MB
        sizeText = [NSString stringWithFormat:@"%.2fMB", folderSize / pow(10, 6)];
    } else if (folderSize >= pow(10, 3)) { // 1MB > size >= 1KB
        sizeText = [NSString stringWithFormat:@"%.2fKB", folderSize / pow(10, 3)];
    } else { // 1KB > size
        sizeText = [NSString stringWithFormat:@"%lldB", folderSize];
    }
    return sizeText;
}


- (float)privateFileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
@end
