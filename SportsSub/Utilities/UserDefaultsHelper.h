//
//  UserDefaultsHelper.h
//  DailyUse
//
//  Created by Kalyan Varma on 8/25/14.

//

#import <Foundation/Foundation.h>

@interface UserDefaultsHelper : NSObject
{
    
}

// custom setters methods for user defaults

+(NSString*)getStringForKey:(NSString*)key;
+(NSInteger)getIntForkey:(NSString*)key;
+(NSDictionary*)getDictForKey:(NSString*)key;
+(NSArray*)getArrayForKey:(NSString*)key;
+(BOOL)getBoolForKey:(NSString*)key;

// custom getter methods for user defaults

+(void)setStringValue:(NSString *)value forKey:(NSString *)key;
+(void)setIntValue:(NSInteger)value forKey:(NSString*)key;
+(void)setDictValue:(NSDictionary*)value forKey:(NSString*)key;
+(void)setArrayValue:(NSArray*)value forKey:(NSString*)key;
+(void)setBoolValue:(BOOL)value forKey:(NSString*)key;


@end
