//
//  PTEQuestion+CoreDataProperties.h
//  PaginationCoreDataExample
//
//  Created by William Boles on 23/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PTEQuestion.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTEQuestion (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *author;
@property (nullable, nonatomic, retain) NSDate *createdDate;
@property (nullable, nonatomic, retain) NSNumber *index;
@property (nullable, nonatomic, retain) NSNumber *questionID;
@property (nullable, nonatomic, retain) PTEPage *page;

@end

NS_ASSUME_NONNULL_END
