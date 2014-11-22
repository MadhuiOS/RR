//
//  MJSecondDetailViewController.m
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "POPUPViewController.h"

@interface POPUPViewController ()

@end

@implementation POPUPViewController

@synthesize delegate;

-(void)viewDidLoad{
    [super viewDidLoad];
    self.selectionArray=[NSMutableArray array];
    
    self.contentTableView.allowsMultipleSelection=YES;
    self.view.layer.borderWidth=2.0;
    self.view.layer.borderColor=[[UIColor grayColor] CGColor];
    self.view.layer.cornerRadius=8.0;
    
    
    
}
- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}
- (IBAction)DonePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate DoneButtonClicked:self selectedArray:[self.selectionArray copy]];

        
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    Sports *sports =[self.contentArray objectAtIndex:indexPath.row];
    //NSLog(@"%@",sports.sportsId);
   // NSLog(@"%@",sports);
    
    cell.textLabel.text =[NSString stringWithFormat:@"%@",sports.sportsName];
    cell.textLabel.textColor=[UIColor blackColor];

    
    //cell.textLabel.text=@"kdkk";
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"   Select Sports";
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     Sports *sports =[self.contentArray objectAtIndex:indexPath.row];
    [self.selectionArray addObject:[NSString stringWithFormat:@"%@",sports.sportsName]];
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    Sports *sports =[self.contentArray objectAtIndex:indexPath.row];
    [self.selectionArray removeObject:[NSString stringWithFormat:@"%@",sports.sportsName]];
}
@end
