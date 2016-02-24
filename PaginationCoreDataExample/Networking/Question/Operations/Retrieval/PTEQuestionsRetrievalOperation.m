//
//  PTEQuestionsRetrievalOperation.m
//  PaginationThrowAwayExample
//
//  Created by William Boles on 15/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "PTEQuestionsRetrievalOperation.h"

#import <CoreDataServices/CDSServiceManager.h>
#import <CoreDataServices/NSManagedObjectContext+CDSRetrieval.h>

#import "PTEFeed.h"
#import "PTEPage.h"
#import "PTEQuestionParser.h"

@interface PTEQuestionsRetrievalOperation ()

@property (nonatomic, strong) NSManagedObjectID *feedID;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) void (^completion)(BOOL successful);
@property (nonatomic, assign) BOOL refresh;

@property (nonatomic, strong) NSOperationQueue *callBackQueue;

- (NSNumber *)indexOfNewPageInFeed:(PTEFeed *)feed;
- (void)reorderIndexInFeed:(PTEFeed *)feed;

@end

@implementation PTEQuestionsRetrievalOperation

#pragma mark - Init

- (instancetype)initWithFeedID:(NSManagedObjectID *)feedID
                          data:(NSData *)data
                       refresh:(BOOL)refresh
                    completion:(void(^)(BOOL successful))completion
{
    self = [super init];
    
    if (self)
    {
        self.feedID = feedID;
        self.data = data;
        self.completion = completion;
        self.callBackQueue = [NSOperationQueue currentQueue];
        self.refresh = refresh;
    }
    
    return self;
}

#pragma mark - Main

- (void)main
{
    [super main];
    
    NSError *serializationError = nil;
    
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:self.data
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&serializationError];
    
    if (serializationError)
    {
        [self.callBackQueue addOperationWithBlock:^
         {
             if (self.completion)
             {
                 self.completion(NO);
             }
         }];
    }
    else
    {
        [[CDSServiceManager sharedInstance].backgroundManagedObjectContext performBlockAndWait:^
        {
            PTEQuestionParser *parser = [[PTEQuestionParser alloc] init];
            PTEPage *page = [parser parseQuestions:jsonResponse];
            
            PTEFeed *feed = [[CDSServiceManager sharedInstance].backgroundManagedObjectContext existingObjectWithID:self.feedID
                                                                                                              error:nil];
            
            page.nextHref = [NSString stringWithFormat:@"%@&page=%@", kPTEBaseURLString, @(feed.pages.count + 1)];
            page.index = [self indexOfNewPageInFeed:feed];
            
            [self reorderIndexInFeed:feed];
            
            if (self.refresh)
            {
                feed.arePagesInSequence = @(!page.fullPage.boolValue);
            }
            
            [feed addPagesObject:page];
            
            /*----------------*/
            
            [[CDSServiceManager sharedInstance] saveBackgroundManagedObjectContext];
        }];
        
        /*----------------*/
        
        [self.callBackQueue addOperationWithBlock:^
         {
             if (self.completion)
             {
                 self.completion(YES);
             }
         }];
    }
}

#pragma mark - PageIndex

- (void)reorderIndexInFeed:(PTEFeed *)feed
{
    NSArray *pages = feed.orderedPages;
    
    for (NSUInteger index = 0; index < pages.count; index++)
    {
        PTEPage *page = pages[index];
        page.index = @(index);
    }
}

- (NSNumber *)indexOfNewPageInFeed:(PTEFeed *)feed
{
    NSNumber *indexOfNewPage = nil;
    
    if (self.refresh)
    {
        indexOfNewPage = @(-1);
    }
    else
    {
        indexOfNewPage = @(feed.pages.count);
    }
    
    return indexOfNewPage;
}

@end
