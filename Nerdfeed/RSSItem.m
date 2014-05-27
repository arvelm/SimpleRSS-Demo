//
//  RSSItem.m
//  Nerdfeed
//
//  Created by Ivan on 14-5-5.
//  Copyright (c) 2014年 Ivan. All rights reserved.
//

#import "RSSItem.h"

@implementation RSSItem

@synthesize parentParserDelegate,link,title,image;

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element",self,elementName);
    if ([elementName isEqual:@"title"]) {
        currentString=[[NSMutableString alloc] init];
        [self setTitle:currentString];
    }
    else if ([elementName isEqual:@"link"]){
        currentString=[[NSMutableString alloc] init];
        [self setLink:currentString];
    }
    else if ([elementName isEqual:@"image"]){
        currentString=[[NSMutableString alloc] init];
        [self setImage:currentString];
    }

}


-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentString appendString:string];
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    currentString=nil;
    if ([elementName isEqual:@"item"]) {
        [parser setDelegate:parentParserDelegate];
    }
}

@end
