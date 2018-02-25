//
//  TaskLoadingManager.h
//  LKLoadingPM
//
//  Created by 杨丰林 on 2017/8/8.
//  Copyright © 2017年 杨丰林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskLoadModel.h"

//缓存主目录
#define YFLCachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"YFLCache"]
//文件名
#define YFLFileName(url) [[url componentsSeparatedByString:@"/"] lastObject]

//文件存放路径（caches）
#define YFLFileFullPath(url) [YFLCachesDirectory stringByAppendingPathComponent:YFLFileName(url)]
//文件已下载长度
#define YFLDownloadLength(url) [[[NSFileManager defaultManager] attributesOfItemAtPath:YFLFileFullPath(url) error:nil][NSFileSize] integerValue]
//储存文件信息的路径（caches）
#define YFLDownloadDetailPath [YFLCachesDirectory stringByAppendingPathComponent:@"downloadDetail.data"]


@interface TaskLoadingManager : NSObject

/**
 * 返回单例对象
 */

+(instancetype)sharedInstance;

/**
 * 开启任务下载资源
 * @param url              下载地址
 * @param progresssBlock   下载进度回调
 * @param stateBlock       下载状态
 */

-(void)download:(NSString *)url progress:(YFLDownloadProgressBlock)progressBlock state:(YFLDownloadStateBlock)stateBlock;
@end
