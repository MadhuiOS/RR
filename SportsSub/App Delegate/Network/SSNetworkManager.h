//
//  NSDBManager.h
//  SportsSub
//
//  Created by Kalyan Varma on 12/11/14.
//  Copyright (c) 2014 Kalyan Varma. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^QueryCompletionBlock)(NSDictionary *response, NSError *errorOrNil);
typedef void (^QueryDictionaryCompletionBlock)(NSDictionary *dict, NSError *errorOrNil);

@interface SSNetworkManager : NSObject
{
    
}

/* get shared instance */
+(id)sharedInstance;

-(void)requestURL:(NSString *)url requestType:(NSString *)requesttype requestrequestData:(NSDictionary *)paramsDict WithBlock:(QueryCompletionBlock)completionBlock;

#pragma mark get default details

-(void)fetchSportsList;
-(void)fetchProfiencyList;



@end
