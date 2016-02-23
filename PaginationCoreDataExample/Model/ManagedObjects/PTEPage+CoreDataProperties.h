//
//  PTEPage+CoreDataProperties.h
//  PaginationCoreDataExample
//
//  Created by William Boles on 23/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PTEPage.h"

#import "PTEQuestion.h"
#import "PTEFeed.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTEPage (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *createdDate;
@property (nullable, nonatomic, retain) NSString *nextHref;
@property (nullable, nonatomic, retain) NSNumber *index;
@property (nullable, nonatomic, retain) NSSet<PTEQuestion *> *questions;
@property (nullable, nonatomic, retain) PTEFeed *feed;

@end

@interface PTEPage (CoreDataGeneratedAccessors)

- (void)addQuestionsObject:(PTEQuestion *)value;
- (void)removeQuestionsObject:(PTEQuestion *)value;
- (void)addQuestions:(NSSet<PTEQuestion *> *)values;
- (void)removeQuestions:(NSSet<PTEQuestion *> *)values;

@end

NS_ASSUME_NONNULL_END
