//
//  DictionaryTableViewController.m
//  MAIMobile
//
//  Created by Алексей Левинтов on 18.01.15.
//  Copyright (c) 2015 MAI. All rights reserved.
//

#import "DictionaryTableViewController.h"
#import "DictionaryTableViewCell.h"
#import "WordViewController.h"
#import <Parse/Parse.h>
@interface DictionaryTableViewController ()
@property NSArray *words;
@end

@implementation DictionaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    PFQuery *query = [PFQuery queryWithClassName:@"SlangWord"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray *array = [NSMutableArray new];
        for (PFObject *obj in objects) {
            NSDictionary *dic =  @{@"word" : obj[@"word"], @"description":obj[@"description"]};
            [array addObject:dic];
            
        }
        self.words = array;
        [[self tableView] reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.words.count;
}


- (DictionaryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DictionaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dictionaryCell" forIndexPath:indexPath];
    NSDictionary *dic = self.words[indexPath.row];
    
    cell.wordLabel.text = dic[@"word"];
    cell.descriptionLabel.text = dic[@"description"];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([[segue identifier] isEqualToString:@"descriptionWordSeque"])
    {
        DictionaryTableViewCell *cell = sender;
        WordViewController *wvc = segue.destinationViewController;
        NSLog(@"%@", wvc);
        wvc.word = @{@"word" : cell.wordLabel.text, @"description":cell.descriptionLabel.text};
      
    }
}


@end
