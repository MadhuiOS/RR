//
//  SignUpViewController.h
//  SportsSub
//
//  Created by Home on 8/31/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController


-(void)updateWithTwitterData:(NSString *)userName;
-(void)UpdateWithFacebookData:(NSString*)FirstName LastName:(NSString*)LastName EmailId:(NSString*)EmailID;

@end
