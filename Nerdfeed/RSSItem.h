//
//  RSSItem.h
//  Nerdfeed
//
//  Created by Ivan on 14-5-5.
//  Copyright (c) 2014年 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSItem : NSObject<NSXMLParserDelegate>
{
    NSMutableString *currentString;
}

@property(nonatomic,weak)id parentParserDelegate;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *link;
@property(nonatomic,strong) NSString *image;

@end
