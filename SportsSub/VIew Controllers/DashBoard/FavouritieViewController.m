//
//  FavouritieViewController.m
//  SportsSub
//
//  Created by Home on 9/1/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "FavouritieViewController.h"
#import "FavoritiesTableViewCell.h"
#import "SSNetworkManager.h"
#import "Utilities.h"
#import "UserDefaultsHelper.h"
#import "SSDBManager.h"
#import "UserFavourites.h"

@interface FavouritieViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tblFavorite;

@end

@implementation FavouritieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{

    [[SSNetworkManager sharedInstance]requestURL:[NSString stringWithFormat:@"%@favourites/%@",DUURL,[UserDefaultsHelper getStringForKey:@"userid"]] requestType:@"POST" requestrequestData:nil WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
        NSLog(@"%@",[[response objectForKey:@"content"] objectForKey:@"favouriteList"]);
        
        [[SSDBManager sharedInstance]saveFavorites:[[response objectForKey:@"content"] objectForKey:@"favouriteList"]];
        [_tblFavorite reloadData];
    }];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20]
                              }];

    self.navigationController.navigationBar.translucent = NO;

    [super viewWillAppear:animated];
    [self setTitle:@"FAVOURITE"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setTitle:@""];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma Table View

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[SSDBManager sharedInstance] getDBFavorites] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeadersCell";
    FavoritiesTableViewCell *cell=(FavoritiesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[FavoritiesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UserFavourites *user=[[[SSDBManager sharedInstance] getDBFavorites] objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text=user.favouriteUserFirstname;
//    [cell updateCell:self];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
