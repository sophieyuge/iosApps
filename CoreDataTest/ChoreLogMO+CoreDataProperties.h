//
//  ChoreLogMO+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Yuge Xiong on 2018-11-06.
//  Copyright © 2018 sophieyuge. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ChoreLogMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChoreLogMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) ChoreMO *choreDone;
@property (nullable, nonatomic, retain) PersonMO *personDid;

@end

NS_ASSUME_NONNULL_END
