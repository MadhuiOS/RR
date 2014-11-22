//
//  NSDBManager.m
//  SportsSub
//
//  Created by Kalyan Varma on 12/11/14.
//  Copyright (c) 2014 Kalyan Varma. All rights reserved.
//


#import "SSNetworkManager.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "SSDBManager.h"
#import "SSAlertView.h"
static NSString *DUURL = @"http://183.182.84.84/sportsub/user/";

static SSNetworkManager *sharedInstance=nil;
@implementation SSNetworkManager


+(id)sharedInstance
{
    @synchronized (self) {
        if (sharedInstance == nil)
        {
            sharedInstance = [self new];
        }
        
    }
    return sharedInstance;
}

-(void)requestURL:(NSString *)url requestType:(NSString *)requesttype requestrequestData:(NSDictionary *)paramsDict WithBlock:(QueryCompletionBlock)completionBlock
{

    @try
    {
        
        AFHTTPClient *leadHttpClient = [[AFHTTPClient alloc] initWithBaseURL: [NSURL URLWithString:url]];
        
        [leadHttpClient setDefaultHeader:@"Content-Type" value:@"application/x-www-form-urlencoded charset=utf-8"];
        
        
        [leadHttpClient postPath:requesttype parameters:paramsDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *jsonObject=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

            NSLog(@"responseObject :%@",jsonObject);
            
            completionBlock(jsonObject,nil);
            
        }
         
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
            
            NSLog(@"error :%@",[error description]);
            
        }];
        
    }
    @catch (NSException *exception)
    {
        NSLog(@"exception :%@",exception);
    }
    

}


#pragma mark get default details

-(void)fetchSportsList
{
    @try
    {
        AFHTTPClient *leadHttpClient = [[AFHTTPClient alloc] initWithBaseURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@sportsList",DUURL]]];

  
        [leadHttpClient setDefaultHeader:@"Content-Type" value:@"application/x-www-form-urlencoded charset=utf-8"];
        
        
        [leadHttpClient getPath:@"GET" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *jsonObject=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
            NSArray *arrSports=[[jsonObject valueForKey:@"content"] valueForKey:@"sportsList"];
            
            [[SSDBManager sharedInstance] saveSportsList:arrSports];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error :%@",[error description]);
            
        }];
    }
    
    
    @catch (NSException *exception) {
        NSLog(@"exception :%@",exception);
    }
}
-(void)fetchProfiencyList
{
    @try
    {
       AFHTTPClient *leadHttpClient = [[AFHTTPClient alloc] initWithBaseURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@profiencyList",DUURL]]];
        
        [leadHttpClient setDefaultHeader:@"Content-Type" value:@"application/x-www-form-urlencoded charset=utf-8"];
        
        
        [leadHttpClient getPath:@"GET" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *jsonObject=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
            [[SSDBManager sharedInstance] saveProfiencyList:[[jsonObject valueForKey:@"content"] objectForKey:@"profiencyList"]];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error :%@",[error description]);
        }];
    }
    
    
    @catch (NSException *exception) {
        NSLog(@"exception :%@",exception);
    }
    
    
}

@end
