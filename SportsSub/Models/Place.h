//
//  Place.h
//  SportsSub
//
//  Created by Home on 10/6/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject
{
    NSString* name;
	NSString* description;
	double latitude;
	double longitude;
}

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* description;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;



@end
