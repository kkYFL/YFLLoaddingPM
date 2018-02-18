//
//  TaskLoadModel.m
//  LKLoadingPM
//
//  Created by 杨丰林 on 2017/8/8.
//  Copyright © 2017年 杨丰林. All rights reserved.
//

#import "TaskLoadModel.h"

@implementation TaskLoadModel

-(float)calculateFileSizeInUnit:(unsigned long long)contentLength{
    if (contentLength >= pow(1024, 3)) {return (float) (contentLength / (float) pow(1024, 3));}
    else if (contentLength >= pow(1024, 2)) {return (float) (contentLength / (float) pow(1024, 2));}
    else if (contentLength >= 1024){ return (float) (contentLength / (float) 1024);}
    else {return (float) (contentLength);}
}


-(NSString *)caculateUnit:(unsigned long long)contentLength{
    if (contentLength >= pow(1024, 3)) {
        return @"GB";
    }else if (contentLength >= pow(1024, 2)){
        return @"MB";
    }else if (contentLength >= 1024){
        return @"KB";
    }else{
        return @"B";
    }
}


//将属性进行编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.fileName forKey:@"fileName"];
    [aCoder encodeInteger:self.totalLength forKey:@"totalLength"];
    [aCoder encodeObject:self.totalSize forKey:@"totalSize"];
}


//将属性进行解码
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.fileName = [aDecoder decodeObjectForKey:@"fileName"];
        self.totalLength = [aDecoder decodeIntegerForKey:@"totalLength"];
        self.totalSize = [aDecoder decodeObjectForKey:@"totalSize"];
    }
    return self;
}

@end
