//
//  PTEFeed+CoreDataProperties.h
//  PaginationCoreDataExample
//
//  Created by William Boles on 23/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PTEFeed.h"

@class PTEPage;

NS_ASSUME_NONNULL_BEGIN

@interface PTEFeed (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<PTEPage *> *pages;

@end

@interface PTEFeed (CoreDataGeneratedAccessors)

- (void)addPagesObject:(PTEPage *)value;
- (void)removePagesObject:(PTEPage *)value;
- (void)addPages:(NSSet<PTEPage *> *)values;
- (void)removePages:(NSSet<PTEPage *> *)values;

@end

NS_ASSUME_NONNULL_END
