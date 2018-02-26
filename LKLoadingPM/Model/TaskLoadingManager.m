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
/** 保存所有下载相关信息字典 */
@property (nonatomic, strong) NSMutableDictionary *sessionModels;
/** 保存所有下载任务(注：key:value = 文件名：下载任务) */
@property (nonatomic, strong) NSMutableDictionary *tasks;



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



/**
 *
 * 开启任务下载资源
 */
-(void)download:(NSString *)url progress:(YFLDownloadProgressBlock)progressBlock state:(YFLDownloadStateBlock)stateBlock{
    
    if (!url) return;

    //下载完成
    if ([self isCompletion:url]) {
        stateBlock(DownLoadStateCompleted);
        NSLog(@"--该资源已经下载完成");
        return;
    }
    
    //暂停
    if ([self.tasks valueForKey:YFLFileName(url)]) {
        
        return;
    }
    
}

#pragma mark - 内部方法

/**
 * 判断该文件是否下载完成
 *
 */

-(BOOL)isCompletion:(NSString *)url{
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

-(void)handle:(NSString *)url{
    NSURLSessionDataTask *task = [self getTask:url];
    //暂停
    if (task.state == NSURLSessionTaskStateRunning) {
        [self pause:url];
    //开始
    }else{
        [self start:url];
    }
    
    //创建缓存目录文件
    
}

/**
 * 根据url获得对应的下载任务
 */
-(NSURLSessionDataTask *)getTask:(NSString *)url{
    return (NSURLSessionDataTask *)[self.tasks valueForKey:YFLFileName(url)];
}

/**
 * 暂停下载
 */
-(void)pause:(NSString *)url{
    NSURLSessionDataTask *task = [self getTask:url];
    //暂停
    [task suspend];
    //暂停回调
    [self getSessionModel:task.taskIdentifier].stateBlock(DownLoadStateSuspended);
}

/**
 *  根据url获取对应的下载信息模型
 */
- (TaskLoadModel *)getSessionModel:(NSUInteger)taskIdentifier{
    return (TaskLoadModel *)[self.sessionModels valueForKey:@(taskIdentifier).stringValue];
}

/**
 * 开始下载
 */
-(void)start:(NSString *)url{
    NSURLSessionDataTask *task = [self getTask:url];
    //恢复下载
    [task resume];
    //状态回调
    [self getSessionModel:task.taskIdentifier].stateBlock(DownloadStateStart);
}



#pragma mark - 懒加载
-(NSMutableArray *)sessionModelsArray{
    if (!_sessionModelsArray) {
        _sessionModelsArray = @[].mutableCopy;
        [_sessionModelsArray addObjectsFromArray:[self getSessionsModels]];
    }
    return _sessionModelsArray;
}

-(NSMutableDictionary *)tasks{
    if (!_tasks) {
        _tasks = [NSMutableDictionary dictionary];
    }
    return _tasks;
}

-(NSMutableDictionary *)sessionModels{
    if (!_sessionModels) {
        _sessionModels = @{}.mutableCopy;
    }
    return _sessionModels;
}





























































@end
