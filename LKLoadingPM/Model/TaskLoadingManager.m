//
//  TaskLoadingManager.m
//  LKLoadingPM
//
//  Created by 杨丰林 on 2017/8/8.
//  Copyright © 2017年 杨丰林. All rights reserved.
//

#import "TaskLoadingManager.h"

@interface TaskLoadingManager ()

@property (nonatomic, strong) NSMutableArray *sessionModelsArray;   //所有下载数据模型数组

@end

@implementation TaskLoadingManager
#pragma mark - 接口
static TaskLoadingManager *_downloadManager;
+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _downloadManager = [[TaskLoadingManager alloc]init];
    });
    return _downloadManager;
}

-(void)download:(NSString *)url progress:(YFLDownloadProgressBlock)progressBlock state:(YFLDownloadStateBlock)stateBlock{
    if (!url) {
        return;
    }

    if (self) {
        
    }
}

#pragma mark - 内部方法

/**
 * 判断该文件是否下载完成
 *
 */

-(BOOL)isCompletion:(NSString *)url{
//    if ([self fileTotalLength:url] && YFLDownloadLength(url) == [self fileTotalLength:url]) {
//        return YES;
//    }
    if ([self fileTotalLength:url] && YFLDownloadLength(url) == [self fileTotalLength:url]) {
        return YES;
    }
    return NO;
}

/**
 * 获取该资源大小
 */
-(NSInteger)fileTotalLength:(NSString *)url{
    for (TaskLoadModel *model in self.sessionModelsArray) {
        if ([model.url isEqualToString:url]) {
            return model.totalLength;
        }
    }
    return 0;
}

/**
 * 读取model
 */
-(NSArray *)getSessionsModels{
    // 文件信息
    NSArray *sessionModels = [NSKeyedUnarchiver unarchiveObjectWithFile:YFLDownloadDetailPath];
    return sessionModels;
}









#pragma mark - 懒加载
-(NSMutableArray *)sessionModelsArray{
    if (!_sessionModelsArray) {
        _sessionModelsArray = @[].mutableCopy;
        [_sessionModelsArray addObjectsFromArray:[self getSessionsModels]];
    }
    return _sessionModelsArray;
}






























































@end
