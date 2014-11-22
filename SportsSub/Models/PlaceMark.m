//
//  PlaceMark.m
//  SportsSub
//
//  Created by Home on 10/6/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "PlaceMark.h"

@implementation PlaceMark

@synthesize coordinate;
@synthesize place;


-(id) initWithPlace: (Place*) p
{
	self = [super init];
	if (self != nil) {
		coordinate.latitude = p.latitude;
		coordinate.longitude = p.longitude;
		self.place = p;
	}
	return self;
}

- (NSString *)subtitle
{
	return self.place.description;
}
- (NSString *)title
{
	return self.place.name;
}


@end
