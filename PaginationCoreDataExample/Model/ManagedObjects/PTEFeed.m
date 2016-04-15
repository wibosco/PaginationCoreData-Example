//
//  PTEFeed.m
//  PaginationCoreDataExample
//
//  Created by William Boles on 23/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "PTEFeed.h"

#import <CoreDataServices/NSManagedObjectContext+CDSRetrieval.h>
#import <CoreDataServices/CDSServiceManager.h>

NSString * kPTEBaseURLString = @"https://api.stackexchange.com/2.2/questions?order=desc&sort=creation&site=stackoverflow";

@implementation PTEFeed

#pragma mark - Feed

+ (PTEFeed *)questionFeedWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return (PTEFeed *)[managedObjectContext cds_retrieveFirstEntryForEntityClass:[PTEFeed class]];
}

+ (PTEFeed *)questionFeed
{
    return [PTEFeed questionFeedWithManagedObjectContext:[CDSServiceManager sharedInstance].mainManagedObjectContext];
}

#pragma mark - Pages

- (NSArray *)orderedPages
{
    NSSortDescriptor *createdDateSort = [NSSortDescriptor sortDescriptorWithKey:@"index"
                                                                      ascending:YES];
    
    return [self.pages sortedArrayUsingDescriptors:@[createdDateSort]];
}

@end
