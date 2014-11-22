//
//  FavoritiesTableViewCell.m
//  SportsSub
//
//  Created by Home on 9/1/14.
//  Copyright (c) 2014 self. All rights reserved.
//


#import "FavoritiesTableViewCell.h"

@interface FavoritiesTableViewCell()
{
    UIImageView *imgFavorite;
    UILabel *lblName;
    UIButton *btnInvite;
}

@end
@implementation FavoritiesTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        UIView *vMainView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        imgFavorite=[[UIImageView alloc] initWithFrame:CGRectMake(vMainView.frame.origin.x+5, +5, 31, 30)];
        imgFavorite.layer.cornerRadius=17.5f;
        [imgFavorite setBackgroundColor:[UIColor greenColor]];
        [vMainView addSubview:imgFavorite];
        
        
        lblName=[[UILabel alloc] initWithFrame:CGRectMake(imgFavorite.frame.origin.x+imgFavorite.frame.size.width+5,imgFavorite.frame.origin.y+4 ,180,20)];
        [vMainView addSubview:lblName];
        //  [wvInvite setBackgroundColor:[UIColor redColor]];
        //  [wvInvite setOpaque:NO];
        
        btnInvite=[[UIButton alloc] initWithFrame:CGRectMake(lblName.frame.origin.x+lblName.frame.size.width+20, lblName.frame.origin.y-5, 56, 23 )];
      //  [btnInvite setTitle:@"INVITE" forState:UIControlStateNormal];
        [btnInvite setImage:[UIImage imageNamed:@"fav_invite.png"] forState:UIControlStateNormal];
        [btnInvite setBackgroundColor:[UIColor colorWithRed:(3.0/255.0) green:(192.0/255.0) blue:(60.0/255.0) alpha:1.0]];
        [btnInvite addTarget:self action:@selector(clickedInviteButton:) forControlEvents:UIControlEventTouchUpInside];
        [vMainView addSubview:btnInvite];
        
        [self.contentView addSubview:vMainView];
    }
    return self;
}

-(void)clickedInviteButton:(id)sender
{
    NSLog(@"clicked Invite Button....");
}


#pragma Update
-(void)updateCell:(id)object
{
    
    [lblName setText:@"Anney"];
    
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
