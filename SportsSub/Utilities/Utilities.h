//
//  Utilities.h

//
//  Created by Infostretch on 10/14/13.
//  Copyright (c) 2013 Infostretch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomProgressView.h"
static NSString *DUURL = @"http://183.182.84.84/sportsub/user/";
static NSString *DUINVITEURL = @"http://183.182.84.84/sportsub/invite/";

#define IS_IPHONE_5 (([UIScreen mainScreen].scale == 2.f && [UIScreen mainScreen].bounds.size.height == 568)?YES:NO)

@interface Utilities : NSObject
{
}


/**
    Added progress view for webservice call
 */
+(void)showProgressView:(UIView *)view;
/**
    Remove progress view
 */
+(void)hideProgressView;








@end
