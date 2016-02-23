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

@property (nonatomic, strong) NSOperationQueue *callBackQueue;

@end

@implementation PTEQuestionsRetrievalOperation

#pragma mark - Init

- (instancetype)initWithFeedID:(NSManagedObjectID *)feedID
                          data:(NSData *)data
                    completion:(void(^)(BOOL successful))completion
{
    self = [super init];
    
    if (self)
    {
        self.feedID = feedID;
        self.data = data;
        self.completion = completion;
        self.callBackQueue = [NSOperationQueue currentQueue];
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
            page.index = @(feed.pages.count);
            
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

@end
