//
//  HomeViewControllerTableViewCell.m
//  SportsSub
//
//  Created by Home on 9/1/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "HomeViewControllerTableViewCell.h"

@interface HomeViewControllerTableViewCell()
{
    UIImageView *imgInvite;
    
    UIWebView *wvInvite;
    
    UIButton *btnAccept;
    UIButton *btnCancel;
    
    UserReceivedInvitation *userInvitation;

}

-(void)toggleButtons;

@end
@implementation HomeViewControllerTableViewCell
@synthesize delegate;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *vMainView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        imgInvite=[[UIImageView alloc] initWithFrame:CGRectMake(vMainView.frame.origin.x+5, +5, 31, 30)];
        imgInvite.layer.cornerRadius=17.5f;
        [imgInvite setBackgroundColor:[UIColor greenColor]];
        [vMainView addSubview:imgInvite];
        
        
        wvInvite=[[UIWebView alloc] initWithFrame:CGRectMake(imgInvite.frame.origin.x+imgInvite.frame.size.width+5,imgInvite.frame.origin.y+10 ,180,20)];
        wvInvite.scrollView.scrollEnabled=NO;
        [vMainView addSubview:wvInvite];
      //  [wvInvite setBackgroundColor:[UIColor redColor]];
      //  [wvInvite setOpaque:NO];
        
        btnAccept=[[UIButton alloc] initWithFrame:CGRectMake(wvInvite.frame.origin.x+wvInvite.frame.size.width+20, wvInvite.frame.origin.y-3, 15, 15  )];
        [btnAccept setImage:[UIImage imageNamed:@"Home_Accept.png"] forState:UIControlStateNormal];
        [btnAccept addTarget:self action:@selector(clickedAcceptButton:) forControlEvents:UIControlEventTouchUpInside];
        [vMainView addSubview:btnAccept];
        
        
        btnCancel=[[UIButton alloc] initWithFrame:CGRectMake(btnAccept.frame.origin.x+btnAccept.frame.size.width+10 , btnAccept.frame.origin.y, btnAccept.frame.size.width, btnAccept.frame.size.height )];
        [btnCancel setImage:[UIImage imageNamed:@"Home_Cancel.png"] forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(clickedCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [vMainView addSubview:btnCancel];

        
        
        
        [self.contentView addSubview:vMainView];
      //  [vMainView setBackgroundColor:[UIColor orangeColor]];
    }
    return self;
}



-(void)clickedAcceptButton:(id)sender
{
    [self.delegate acceptInvitation:userInvitation.inviteId];
}

-(void)clickedCancelButton:(id)sender
{
    [self.delegate rejectInvitation:userInvitation.inviteId];
}



#pragma Update
-(void)updateCell:(UserReceivedInvitation *)userInv
{
    userInvitation=userInv;
    
    [self toggleButtons];
    
//    if (userInv.inviteAccepted==[NSNumber numberWithInt:0]|| userInv.inviteRejected==[NSNumber numberWithInt:0])
//    {
        [btnAccept setHidden:NO];
        [btnCancel setHidden:NO];
//    }
    
    
    NSString *strHtml=[NSString stringWithFormat:@"<html><head><title></title></head><body style='font-family:Arial;padding:0x;margin:0px;background-color:transparent;font-size:8px;color:#bdc0c2'><strong>%@</strong> you to play <strong>%@</strong></body></html>",userInv.fromFirstname,userInv.sportName];
    
    
    [wvInvite loadHTMLString:strHtml baseURL:nil];
    
}

-(void)toggleButtons
{
    [btnAccept setHidden:YES];
    [btnCancel setHidden:YES];
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
