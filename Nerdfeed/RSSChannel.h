//
//  RSSChannel.h
//  Nerdfeed
//
//  Created by Ivan on 14-5-5.
//  Copyright (c) 2014年 Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSChannel : NSObject<NSXMLParserDelegate>
{
    NSMutableString *currentString;
}

@property(nonatomic,weak) id parentParserDelegate;

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *infoString;
@property(nonatomic,readonly,strong) NSMutableArray *items;

@end
