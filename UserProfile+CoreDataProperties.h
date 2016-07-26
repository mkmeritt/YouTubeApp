//
//  UserProfile+CoreDataProperties.h
//  YouTubeApp
//
//  Created by Mark Meritt on 2016-07-25.
//  Copyright © 2016 Apptist. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserProfile.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserProfile (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *mood;
@property (nullable, nonatomic, retain) NSString *recentlyWatched;

@end

NS_ASSUME_NONNULL_END
