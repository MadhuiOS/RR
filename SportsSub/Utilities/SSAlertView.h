//
//  DUAlertView.h

//
//  Created by Kalyan Varma on 8/25/14.

//

#import <Foundation/Foundation.h>

@interface SSAlertView : NSObject

// showing alert view
+ (void)showWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;

@end
