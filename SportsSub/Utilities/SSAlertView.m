//
//  DUAlertView.m
//  DailyUse
//
//  Created by Kalyan Varma on 8/25/14.

//
#import <UIKit/UIKit.h>
#import "SSAlertView.h"

@implementation SSAlertView

+ (void)showWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    UIAlertView  * alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
    [alert show];
}
@end
