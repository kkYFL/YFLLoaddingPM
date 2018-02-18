//
//  TaskLoadModel.h
//  LKLoadingPM
//
//  Created by 杨丰林 on 2017/8/8.
//  Copyright © 2017年 杨丰林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DownLoadState) {
    DownloadStateStart,          /**下载开始**/
    DownLoadStateSuspended,      /**下载暂停**/
    DownLoadStateCompleted,      /**下载完成**/
    DownLoadStateFailed          /**下载失败**/
};

typedef void(^YFLDownloadProgressBlock)(CGFloat progresss,NSString *speed,NSString *remainTime,NSString *writtenSize,NSString *totalSize);
typedef void(^YFLDownloadStateBlock)(DownLoadState state);

@interface TaskLoadModel : NSObject <NSCoding>
@property (nonatomic, strong) NSOutputStream *stream;   //流
@property (nonatomic, copy) NSString *url;              //下载地址
@property (nonatomic, strong) NSDate *startTime;        //下载开始时间
@property (nonatomic, copy) NSString *fileName;         //文件名
@property (nonatomic, copy) NSString *totalSize;        //文件大小
@property (nonatomic, assign) NSInteger totalLength;    //获取服务器这次请求，返回数据总长度


@property (nonatomic, copy) YFLDownloadProgressBlock progressBlock; //下载进度回调
@property (nonatomic, copy) YFLDownloadStateBlock stateBlock;       //下载状态回调


-(float)calculateFileSizeInUnit:(unsigned long long)contentLength;//计算文件大小方法
-(NSString *)caculateUnit:(unsigned long long)contentLength;      //计算文件大小单位方法
@end
