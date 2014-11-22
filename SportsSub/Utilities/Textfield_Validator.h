//
//  Textfield_Validator.h
//  TextField_Validate
//
//  Created by Kalyan Varma on 8/25/14.
//  Copyright (c) 2014 Infostretch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Textfield_Validator : NSObject
{
    
}

// textfields validations for different scenarios

+(BOOL)isTextfieldNotEmpty:(NSString *)string;

+(BOOL)isTextfieldContainsText:(NSString *)string count:(int )count;

+(BOOL)isTextfieldContainsValidEmail:(NSString *)string;

+(BOOL)isTextfieldContainsOnlyNumbers:(NSString *)string;

+(BOOL)isTextfieldContainsOnlyAlphabets:(NSString *)string;

+(BOOL)isTextfieldContainsSpecialCharacters:(NSString *)inputString;

+(BOOL)isTextfieldContainsSameText:(NSString *)firstString secondField:(NSString *)secondString ;

@end
