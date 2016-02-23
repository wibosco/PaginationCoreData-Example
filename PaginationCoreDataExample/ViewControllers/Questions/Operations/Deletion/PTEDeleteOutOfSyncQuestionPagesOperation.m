//
//  PTEDeleteQuestionsOperation.m
//  PaginationCoreDataExample
//
//  Created by William Boles on 23/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "PTEDeleteOutOfSyncQuestionPagesOperation.h"

#import <CoreDataServices/CDSServiceManager.h>
#import <CoreDataServices/NSManagedObjectContext+CDSRetrieval.h>
#import <CoreDataServices/NSManagedObjectContext+CDSDelete.h>

#import "PTEPage.h"
#import "PTEFeed.h"

@implementation PTEDeleteOutOfSyncQuestionPagesOperation

#pragma mark - Main

- (void)main
{
    [super main];
    
    [[CDSServiceManager sharedInstance].backgroundManagedObjectContext performBlockAndWait:^
     {
         NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index"
                                                                          ascending:YES];
         
         PTEPage *topPage = (PTEPage *)[[CDSServiceManager sharedInstance].backgroundManagedObjectContext cds_retrieveFirstEntryForEntityClass:[PTEPage class]
                                                                                                                                     predicate:nil
                                                                                                                               sortDescriptors:@[sortDescriptor]];
         
         
         NSPredicate *deletionPredicate = [NSPredicate predicateWithFormat:@"objectID != %@", topPage.objectID];
         
         [[CDSServiceManager sharedInstance].backgroundManagedObjectContext cds_deleteEntriesForEntityClass:[PTEPage class]
                                                                                                  predicate:deletionPredicate
                                                                                          saveAfterDeletion:NO];
         
         [[CDSServiceManager sharedInstance] saveBackgroundManagedObjectContext];
     }];
}

@end
