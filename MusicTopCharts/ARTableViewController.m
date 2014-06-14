//
//  ARTableViewController.m
//  MusicTopCharts
//
//  Created by Adam Rais on 13/06/2014.
//  Copyright (c) 2014 Adam Rais. All rights reserved.
//

#import "ARTableViewController.h"
#import "ARBlogPost.h"

@interface ARTableViewController ()

@end

@implementation ARTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.blogPost = [[ARBlogPost alloc] init];
    self.blogPost.jsonMutable = [NSMutableArray array];
    
    for (NSDictionary *post in self.blogPost.blogData) {
        ARBlogPost *bp = [ARBlogPost blogPostWithSongTitle: [post objectForKey:@"title"] ];
        bp.artist = [post objectForKey:@"rank"];
        bp.image = [[post objectForKey:@"image"] objectForKey:@"src"];
        [self.blogPost.jsonMutable addObject:bp];
    }
    
    // Initialize Refresh Control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    // Configure Refresh Control
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    // Configure View Controller
    [self setRefreshControl:refreshControl];
    
    UIImage *image = [UIImage imageNamed:@"Wall-8.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.tableView.backgroundView = imageView;
    self.tableView.backgroundView.layer.zPosition -= 1;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, -15.0f, 0.0f, 0.0f);
    
}

- (void)refresh:(id)sender
{
    NSLog(@"Refreshing");
    [self.tableView reloadData];
    
    // End Refreshing
    [(UIRefreshControl *)sender endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.blogPost.jsonMutable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    ARBlogPost *post = [self.blogPost.jsonMutable objectAtIndex:indexPath.row];
    NSData *imageData = [NSData dataWithContentsOfURL:post.imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    cell.imageView.image = image;
    cell.textLabel.text = post.songTitle;
    cell.detailTextLabel.text = post.artist;
    cell.backgroundColor = [UIColor colorWithRed:1.000 green:0.415 blue:0.427 alpha:0.000];
    
    return cell;
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

@end
