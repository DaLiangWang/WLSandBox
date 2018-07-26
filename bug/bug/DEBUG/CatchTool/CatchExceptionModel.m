//
//  CatchExceptionModel.m
//  bug
//
//  Created by 王亮 on 2018/7/20.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "CatchExceptionModel.h"

@implementation CatchExceptionModel


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.reason forKey:@"reason"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.cellStack forKey:@"cellStack"];
    
}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.reason = [aDecoder decodeObjectForKey:@"reason"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.cellStack = [aDecoder decodeObjectForKey:@"cellStack"];
    }
    return self;
}

@end
