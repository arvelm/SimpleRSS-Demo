//
//  ListViewController.m
//  Nerdfeed
//
//  Created by Ivan on 14-5-5.
//  Copyright (c) 2014年 Ivan. All rights reserved.
//

#import "ListViewController.h"
#import "RSSChannel.h"
#import "RSSItem.h"
#import "WebViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController
@synthesize webViewController;

- (id)initWithStyle:(UITableViewStyle)style;
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title=(NSString *) channel;
        //  #pragma mark - 发送fetchEntries方法
        [self fetchEntries];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[channel items] count];
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
     
     if (cell==nil) {
         cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
     }
     
     RSSItem *item=[[channel items] objectAtIndex:[indexPath row]];
     
//     UIImage *myImage2 =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://cdn.ifanr.cn/wp-content/uploads/2014/05/IMG_1048.jpg"]]];
     
     
//     NSURL *url=[NSURL URLWithString:[item image]];
//     UIImage *myImage2 =[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[item image]]]];
//     cell.imageView.image=myImage2;
     
//     cell.font=[UIFont systemFontOfSize:14.0];
     
     [[cell textLabel] setText:[item title]];
     
 
     return cell;
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self navigationController] pushViewController:webViewController animated:YES];
    
    RSSItem *entry=[[channel items] objectAtIndex:[indexPath row]];
    
    NSURL *url=[NSURL URLWithString:[entry link]];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    webViewController.view=nil;
    
    [[webViewController webView] loadRequest:request];
    
    [[webViewController navigationItem] setTitle:[entry title]];
    
//    [[self tableView] reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)fetchEntries
{
    xmldata=[[NSMutableData alloc] init];
    
//    NSURL *url=[NSURL URLWithString:@"http://forums.bignerdranch.com/smartfeed.php?"@"limit=1_DAY&sort_by=standard&feed_type=RSS2.0&feed_style=COMPACT"];
    
//    NSURL *url=[NSURL URLWithString:@"http://www.ifanr.com/feed"];
    NSURL *url=[NSURL URLWithString:@"http://news.163.com/special/00011K6L/rss_newstop.xml"];

    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}
//  #pragma mark - NSURLConnection 委托 － connection didFailWithError:
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [xmldata appendData:data];
}

//  #pragma mark - NSURLConnection 委托 － connectionDidFinishLoading:
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    NSString *xmlCheck=[[NSString alloc] initWithData:xmldata encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"xmlCheck =  %@",xmlCheck);
    
    
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:xmldata];
    [parser setDelegate:self];
    [parser parse];
    
    xmldata=nil;
    connection=nil;
    [[self tableView] reloadData];
    self.navigationItem.title=[channel title];
    NSLog(@"\n %@\n %@\n %@\n",channel,[channel title],[channel infoString]);
}

//  #pragma mark - NSURLConnection 委托 － connection didFailWithError:
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    connection=nil;
    
    xmldata=nil;
    
    NSString *errorString=[NSString stringWithFormat:@"Fetch failed: %@",[error localizedDescription]];
    
    UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
    [av show];
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element",self,elementName);
    
    if([elementName isEqual:@"channel"])
    {
        channel=[[RSSChannel alloc] init];
        
        [channel setParentParserDelegate:self];
        
        [parser setDelegate:channel];

    }
    
}
























@end
