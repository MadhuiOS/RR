//
//  CustomView.m
//  CustomActivityIndicator
//
//  Created by nikhil on 11/12/13.
//  Copyright (c) 2013 nikhil. All rights reserved.
//

#import "CustomProgressView.h"

@implementation CustomProgressView

-(id)init
{
    self=[super init];
    if(self) {
        [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
        activityView = [[UIActivityIndicatorView alloc] init];
        [activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activityView startAnimating];
        [self addSubview:activityView];
        [activityView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:activityView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:activityView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    }
    return self;
}

@end
