//
//  UserInvitationViewController.m
//  SportsSub
//
//  Created by Kalyan Varma on 19/11/14.
//  Copyright (c) 2014 Kalyan Varma. All rights reserved.
//

#import "UserInvitationViewController.h"
#import "FavoritiesTableViewCell.h"
#import "Utilities.h"
#import "SSNetworkManager.h"
#import "UserDefaultsHelper.h"
#import "SSDBManager.h"
#import "SSAlertView.h"
@interface UserInvitationViewController ()

@end

@implementation UserInvitationViewController

- (void)viewDidLoad
{
    self.title = @"Sent Invitations";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20]
                              }];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self getSentAllInvitations];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidLayoutSubviews{
    if (IS_IPHONE_5)
    {
        
    }
    else
    {
    
        self.inviteTableView.frame=CGRectMake(0, 0, 320, 386);
        
        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[[SSDBManager sharedInstance] getDBSentInvitations] count]==0)
    {
        [SSAlertView showWithTitle:@"No Sent Invitations" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
    }
}

-(void)getSentAllInvitations
{
    
    [Utilities showProgressView:self.view];
    [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@sentRequest/3",DUINVITEURL] requestType:@"POST" requestrequestData:nil WithBlock:^(NSDictionary *response, NSError *errorOrNil)
     {
         
         
         
         if ([[response valueForKey:@"error"] isKindOfClass:[NSNull class]])
         {
             
             if ([response objectForKey:@"content"])
             {
                
                 NSLog(@"%@",[[response objectForKey:@"content"] objectForKey:@"sentRequestList"]);
                 
                 
                 NSLog(@"%@",[errorOrNil description]);
                 
                 
                 [Utilities hideProgressView];
                 
                 
                 [[SSDBManager sharedInstance]saveSentInvitations:[[response objectForKey:@"content"] objectForKey:@"sentRequestList"]];
             }
             else
             {
                 
             }
           
             }
           [Utilities hideProgressView];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Table View
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[SSDBManager sharedInstance] getDBSentInvitations] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeadersCell";
    FavoritiesTableViewCell *cell=(FavoritiesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FavoritiesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    //  Tweets *tweet=[[[Content shared] leaderTweets] objectAtIndex:indexPath.row];
//    cell.textLabel.text =[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [cell updateCell:self];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
