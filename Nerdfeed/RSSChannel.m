//
//  RSSChannel.m
//  Nerdfeed
//
//  Created by Ivan on 14-5-5.
//  Copyright (c) 2014年 Ivan. All rights reserved.
//

#import "RSSChannel.h"
#import "RSSItem.h"

@implementation RSSChannel
@synthesize items,title,infoString,parentParserDelegate;

-(id)init
{
    self=[super init];
    if(self)
    {
        items=[[NSMutableArray alloc] init];
    }

    return self;
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element",self,elementName);
    
    if([elementName isEqual:@"title"])
    {
        currentString=[[NSMutableString alloc] init];
        [self setTitle:currentString];
    }
    else if ([elementName isEqual:@"description"])
    {
        currentString=[[NSMutableString alloc] init];
        [self setInfoString:currentString];
    }
    
    else if ([elementName isEqual:@"item"])
    {
        RSSItem *entry=[[RSSItem alloc] init];
        [entry setParentParserDelegate:self];
        [parser setDelegate:entry];
        
        [items addObject:entry];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    currentString=nil;
    
    if([elementName isEqual:@"channel"])
    {
        [parser setDelegate:parentParserDelegate];
    }
}



@end
