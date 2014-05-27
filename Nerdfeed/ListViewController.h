//
//  ListViewController.h
//  Nerdfeed
//
//  Created by Ivan on 14-5-5.
//  Copyright (c) 2014年 Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSSChannel;
@class WebViewController;

@interface ListViewController : UITableViewController<NSXMLParserDelegate>
{
//  #pragma mark - 保存网络连接
    NSURLConnection *connection;
    
//  #pragma mark - 该网络连接获取的数据
    NSMutableData *xmldata;
    
    RSSChannel *channel;
}

@property(nonatomic,strong)WebViewController *webViewController;

//  #pragma mark - 方法（NSURL、NSURLRequest、NSURLConnection）
-(void)fetchEntries;

//  # 创建缩略图
-(UIImage *)setThumbnailFromImage:(UIImage *) image;

@end
