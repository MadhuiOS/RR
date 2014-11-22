//

//

#import "SSDBManager.h"
#import "SSNetworkManager.h"
#import "UserFavourites.h"
@implementation SSDBManager

static SSDBManager *sharedInstance=nil;


#pragma mark - Init Methods

+(id)sharedInstance
{
    @synchronized (self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [self new];
        }
    }
    return sharedInstance;
}

#pragma mark - CoreData Maintenance

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

#pragma mark - Database core Methods

+(NSManagedObjectContext *)getContext
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return  appDelegate.managedObjectContext;
}

+(BOOL)saveContext
{
    NSError *error;
    if (![[SSDBManager getContext] save:&error])
    {
        return NO;
    }
    return YES;
}

+(NSManagedObject *)getManagedObject:(NSString *)type
{
    NSManagedObjectContext *context = [SSDBManager getContext];
    return [NSEntityDescription insertNewObjectForEntityForName:type inManagedObjectContext:context];
}

+(NSFetchRequest *)getFetchRequestWithEntity:(NSString *)entity andOwnPredicate:(NSPredicate *)predicate
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:[SSDBManager getContext]] ;
    NSFetchRequest *request = [[NSFetchRequest alloc] init] ;
    [request setEntity:entityDescription];
    if(predicate)
    {
        [request setPredicate:predicate];
    }
    return request;
}

+(NSFetchRequest *)getFetchRequestWithEntity:(NSString *)entity andPredicate:(NSString *)predicate
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:[SSDBManager getContext]] ;
   // [NSManagedObjectModel entities];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init] ;
    [request setEntity:entityDescription];
    if(predicate)
    {
        NSPredicate *fetchPredicate = [NSPredicate predicateWithFormat:predicate];
        [request setPredicate:fetchPredicate];
    }
    return request;
}

#pragma mark - saving data methods

-(void)saveSportsList:(id)defaultData
{
    
    for (NSDictionary *dict in defaultData)
    {
        Sports *sports =  (Sports *)[NSEntityDescription insertNewObjectForEntityForName:@"Sports" inManagedObjectContext:[SSDBManager getContext]];
        [sports setSportsId:[dict objectForKey:@"sportsId"]];
        [sports setSportsName:[dict objectForKey:@"sportsName"]];
        [SSDBManager saveContext];
    }
    
    if ([[[SSDBManager sharedInstance] getDBProfiencyList] count]==0)
    {
        [[SSNetworkManager sharedInstance] fetchProfiencyList];
    }
    
}
-(void)saveProfiencyList:(id)defaultData;
{
    for (NSDictionary *dict in defaultData)
    {
        
   Proficiency *profiency =  (Proficiency *)[NSEntityDescription insertNewObjectForEntityForName:@"Proficiency" inManagedObjectContext:[SSDBManager getContext]];
    [profiency setProficiencyId:[dict objectForKey:@"proficiencyId"]];
    [profiency setProficiencyLevel:[dict objectForKey:@"proficiencyLevel"]];
    [SSDBManager saveContext];
    }
}

-(void)saveUserProfile:(id)dataDict
{
    UserProfile *userProfile;
    NSError *error;
    NSManagedObjectID *editObjectID;
    if (userProfile)
    {
        editObjectID = [userProfile objectID];
        userProfile = (UserProfile *)[[SSDBManager getContext]
                                  existingObjectWithID:editObjectID
                                  error:&error];
    }
    else
    {
        userProfile =  (UserProfile *)[NSEntityDescription insertNewObjectForEntityForName:@"UserProfile" inManagedObjectContext:[SSDBManager getContext]];
    }
    
    
    [userProfile setUserDOB:[NSString stringWithFormat:@"%@",[dataDict objectForKey:@"userDOB"]]];
    [userProfile setUserEmail:[dataDict objectForKey:@"userEmail"]];
    [userProfile setUserFacebookId:[dataDict objectForKey:@"userFacebookId"]];
    [userProfile setUserTwitterId:[dataDict objectForKey:@"userTwitterId"]];
    [userProfile setUserFirstName:[dataDict objectForKey:@"userEmail"]];
    [userProfile setUserImage:[dataDict objectForKey:@"userImage"]];
    [userProfile setUserThumbImage:[dataDict objectForKey:@"userThumbImage"]];
    [userProfile setUserLongitude:[dataDict objectForKey:@"userLatitude"]];
    [userProfile setUserLatitude:[dataDict objectForKey:@"userLongitude"]];
    [userProfile setUserLastName:[dataDict objectForKey:@"userLastName"]];
    [userProfile setUserId:[dataDict objectForKey:@"userId"]];
    [userProfile setUserGender:[dataDict objectForKey:@"userGender"]];

    [SSDBManager saveContext];
}

-(void)saveReceivedInvitations:(id)defaultData
{
    
    if ([defaultData count]>0)
    {
        
        NSArray *receivedINvotations=[self getDBReceivedInvitations];
    
        for (UserReceivedInvitation *user in receivedINvotations)
        {
            [[SSDBManager getContext]deleteObject:user];
            
            [SSDBManager saveContext];
        }
       
    }
    
    for (NSDictionary *dict in defaultData)
    {
        
        UserReceivedInvitation *userReceivedInvitation =  (UserReceivedInvitation *)[NSEntityDescription insertNewObjectForEntityForName:@"UserReceivedInvitation" inManagedObjectContext:[SSDBManager getContext]];
        
        [userReceivedInvitation setFromFirstname:[dict objectForKey:@"fromFirstname"]];
        
        [userReceivedInvitation setFromLastname:[dict objectForKey:@"fromLastname"]];
        [userReceivedInvitation setInviteAccepted:[NSNumber numberWithFloat:
                                      [[dict objectForKey:@"inviteAccepted"] integerValue]]];

        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dateFormat dateFromString:[dict objectForKey:@"inviteCreatedOn"]];
        if (date)
        {
            [userReceivedInvitation setInviteCreatedOn:date];
        }
        
        [userReceivedInvitation setInviteDeleted:[NSNumber numberWithFloat:
                                     [[dict objectForKey:@"inviteDeleted"] integerValue]]];

        
        [userReceivedInvitation setInviteId:[NSNumber numberWithFloat:
                                [[dict objectForKey:@"inviteId"] integerValue]]];
        
        [userReceivedInvitation setInviteInstruction:[dict objectForKey:@"inviteInstruction"]];
        
        [userReceivedInvitation setInviteLatitude:[NSNumber numberWithFloat:
                                      [[dict objectForKey:@"inviteLatitude"] floatValue]]];
        [userReceivedInvitation setInviteLongitude:[NSNumber numberWithFloat:
                                       [[dict objectForKey:@"inviteLongitude"] floatValue]]];
        
        [userReceivedInvitation setUserthumbimageurl:[dict objectForKey:@"fromUserThumbImage"]];
        [userReceivedInvitation setUserimageurl:[dict objectForKey:@"fromUserImage"]];
        
        NSDate *date2 = [dateFormat dateFromString:[dict objectForKey:@"inviteModifiedOn"]];
        
        if (date2)
        {
            [userReceivedInvitation setInviteModifiedOn:date2];
        }

        [userReceivedInvitation setInviteRejected:[NSNumber numberWithFloat:
                                      [[dict objectForKey:@"inviteRejected"] integerValue]]];
        NSDate *date3 = [dateFormat dateFromString:[dict objectForKey:@"inviteWhen"]];
        
        if (date3)
        {
            [userReceivedInvitation setInviteWhen:date3];
        }
        [userReceivedInvitation setInviteWhere:[dict objectForKey:@"inviteWhere"]];
        [userReceivedInvitation setSportName:[dict objectForKey:@"sportName"]];

    
        [SSDBManager saveContext];
    }
}



-(void)saveSentInvitations:(id)defaultData
{
    
    if ([defaultData count]>0)
    {
        
        NSArray *receivedINvotations=[self getDBReceivedInvitations];
        
        for (UserReceivedInvitation *user in receivedINvotations)
        {
            [[SSDBManager getContext]deleteObject:user];
            
            [SSDBManager saveContext];
        }
        
    }
    
    for (NSDictionary *dict in defaultData)
    {
        
        UserSentInvitation *profiency =  (UserSentInvitation *)[NSEntityDescription insertNewObjectForEntityForName:@"UserSentInvitation" inManagedObjectContext:[SSDBManager getContext]];
        
        [profiency setSenTToFirstname:[dict objectForKey:@"fromFirstname"]];
        
        [profiency setSenTToLastname:[dict objectForKey:@"fromLastname"]];
        [profiency setInviteAccepted:[NSNumber numberWithFloat:
                                      [[dict objectForKey:@"inviteAccepted"] integerValue]]];
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dateFormat dateFromString:[dict objectForKey:@"inviteCreatedOn"]];
        if (date)
        {
            [profiency setInviteCreatedOn:date];
        }
        
        [profiency setInviteDeleted:[NSNumber numberWithFloat:
                                     [[dict objectForKey:@"inviteDeleted"] integerValue]]];
        
        
        [profiency setInviteId:[NSNumber numberWithFloat:
                                [[dict objectForKey:@"inviteId"] integerValue]]];
        
        [profiency setInviteInstruction:[dict objectForKey:@"inviteInstruction"]];
        
        [profiency setInviteLatitude:[NSNumber numberWithFloat:
                                      [[dict objectForKey:@"inviteLatitude"] floatValue]]];
        [profiency setInviteLongitude:[NSNumber numberWithFloat:
                                       [[dict objectForKey:@"inviteLongitude"] floatValue]]];
        
        [profiency setTouserthumbimageurl:[dict objectForKey:@"fromUserThumbImage"]];
        [profiency setTouserimageurl:[dict objectForKey:@"fromUserImage"]];
        
        NSDate *date2 = [dateFormat dateFromString:[dict objectForKey:@"inviteModifiedOn"]];
        
        if (date2)
        {
            [profiency setInviteModifiedOn:date2];
        }
        
        [profiency setInviteRejected:[NSNumber numberWithFloat:
                                      [[dict objectForKey:@"inviteRejected"] integerValue]]];
        NSDate *date3 = [dateFormat dateFromString:[dict objectForKey:@"inviteWhen"]];
        
        if (date3)
        {
            [profiency setInviteWhen:date3];
        }
        [profiency setInviteWhere:[dict objectForKey:@"inviteWhere"]];
        [profiency setSportName:[dict objectForKey:@"sportName"]];
        
        
        [SSDBManager saveContext];
    }
}

-(void)saveFavorites:(id)defaultData
{
    if ([defaultData count]>0)
    {
        NSArray *receivedINvotations=[self getDBFavorites];
        
        for (UserFavourites *user in receivedINvotations)
        {
            [[SSDBManager getContext]deleteObject:user];
            
            [SSDBManager saveContext];
        }
        
    }
    
    for (NSDictionary *dict in defaultData)
    {
        
        UserFavourites *favourites =  (UserFavourites *)[NSEntityDescription insertNewObjectForEntityForName:@"UserFavourites" inManagedObjectContext:[SSDBManager getContext]];
        
        [favourites setFavouriteId:[NSNumber numberWithFloat:
                                    [[dict objectForKey:@"favouriteId"] integerValue]]];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [dateFormat dateFromString:[dict objectForKey:@"inviteCreatedOn"]];
        if (date) {
               [favourites setFavouriteUserDOB:date];
        }
     
        [favourites setFavouriteUserEmailId:[dict objectForKey:@"favouriteUserEmailId"]];
        
        [favourites setFavouriteUserGender:[dict objectForKey:@"favouriteUserGender"]];
        [favourites setFavouriteUserImage:[dict objectForKey:@"favouriteUserImage"]];
        [favourites setFavouriteUserLastname:[dict objectForKey:@"favouriteUserLastname"]];
        [favourites setFavouriteUserThumbImage:[dict objectForKey:@"favouriteUserThumbImage"]];
        [SSDBManager saveContext];
    }
}

+(UserProfile *)getDBUserProfile
{
    NSError *error;
    NSArray *array = [[SSDBManager getContext] executeFetchRequest:[SSDBManager getFetchRequestWithEntity:@"UserProfile" andPredicate:nil] error:&error];
    return [array lastObject];
}
#pragma mark - fetch  database methods

-(NSArray *)getDBSportsList
{
    NSError *error;
    NSArray *array = [[SSDBManager getContext] executeFetchRequest:[SSDBManager getFetchRequestWithEntity:@"Sports" andPredicate:nil] error:&error];
    return array;
}
-(NSArray *)getDBProfiencyList
{
    NSError *error;
    NSArray *array = [[SSDBManager getContext] executeFetchRequest:[SSDBManager getFetchRequestWithEntity:@"Proficiency" andPredicate:nil] error:&error];
    return array;
}

-(NSArray *)getDBReceivedInvitations
{
    NSError *error;
    NSArray *array = [[SSDBManager getContext] executeFetchRequest:[SSDBManager getFetchRequestWithEntity:@"UserReceivedInvitation" andPredicate:nil] error:&error];
    return array;
}
-(NSArray *)getDBSentInvitations
{
    NSError *error;
    NSArray *array = [[SSDBManager getContext] executeFetchRequest:[SSDBManager getFetchRequestWithEntity:@"UserSentInvitation" andPredicate:nil] error:&error];
    return array;
}
-(NSArray *)getDBFavorites
{
    NSError *error;
    NSArray *array = [[SSDBManager getContext] executeFetchRequest:[SSDBManager getFetchRequestWithEntity:@"UserFavourites" andPredicate:nil] error:&error];
    return array;
}

@end
