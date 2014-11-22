//
//  Utilities.m
//
//  Created by Kalyan Varma on 8/25/14.
//  Copyright (c) 2013 Infostretch. All rights reserved.
//

#import "Utilities.h"
#import "CustomProgressView.h"

@implementation Utilities
static CustomProgressView *progressView;


#pragma mark Progress view methods

+(void)showProgressView:(UIView *)view;
{
    if(!view) return;
    progressView  = [[CustomProgressView alloc]init];
    [view addSubview:progressView];
    [progressView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:progressView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:progressView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:progressView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:progressView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
}

+(void)hideProgressView
{
    [progressView removeFromSuperview];
}






@end
