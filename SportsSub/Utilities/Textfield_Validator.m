//
//  Textfield_Validator.m
//  TextField_Validate
//
//  Created by Kalyan Varma on 8/25/14.
//  Copyright (c) 2014 Infostretch. All rights reserved.
//

#import "Textfield_Validator.h"

@implementation Textfield_Validator

#pragma mark - Custom helper methods

+(BOOL)isTextfieldNotEmpty:(NSString *)string
{
    if (string.length>0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(BOOL)isTextfieldContainsText:(NSString *)string count:(int )count
{
    if (string.length>count)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(BOOL)isTextfieldContainsValidEmail:(NSString *)string
{
    NSString *emailid = string;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL myStringMatchesRegEx=[emailTest evaluateWithObject:emailid];
    return myStringMatchesRegEx;
}

+(BOOL)isTextfieldContainsOnlyNumbers:(NSString *)string
{
    NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered;
    filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

+(BOOL)isTextfieldContainsOnlyAlphabets:(NSString *)string
{
    NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
    return YES;
}

+(BOOL)isTextfieldContainsSpecialCharacters:(NSString *)textString
{
    if ([self string:textString matches:@"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,10}$"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
 
}

+(BOOL)isTextfieldContainsSameText:(NSString *)firstString secondField:(NSString *)secondString ;
{
    if ([firstString isEqualToString:secondString])
    {
        return YES;
    }
    else
    {
        return NO;

    }
}


+ (BOOL)string:(NSString *)text matches:(NSString *)pattern
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    
    NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    
    return matches.count > 0;
}


@end
