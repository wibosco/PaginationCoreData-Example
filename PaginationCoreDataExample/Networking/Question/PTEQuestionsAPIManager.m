//
//  PTEQuestionsAPIManager.m
//  PaginationThrowAwayExample
//
//  Created by Boles on 11/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "PTEQuestionsAPIManager.h"

#import "PTEQueueManager.h"
#import "PTEFeed.h"
#import "PTEQuestionsRetrievalOperation.h"
#import "PTEPage.h"

@implementation PTEQuestionsAPIManager

#pragma mark - Retrieval

+ (void)retrievalQuestionsForFeed:(PTEFeed *)feed
                          refresh:(BOOL)refresh
                       completion:(void(^)(BOOL successful))completion
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = nil;
    
    if (feed.pages.count > 0)
    {
        PTEPage *page = [feed.orderedPages lastObject];
        url = [NSURL URLWithString:page.nextHref];
    }
    else
    {
        NSString *urlString = [[NSMutableString alloc] initWithString:kPTEBaseURLString];
        url = [NSURL URLWithString:urlString];
    }
    
    NSManagedObjectID *feedObjectID = feed.objectID;
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {
                                      dispatch_async(dispatch_get_main_queue(), ^
                                                     {
                                                         PTEQuestionsRetrievalOperation *operation = [[PTEQuestionsRetrievalOperation alloc] initWithFeedID:feedObjectID
                                                                                                                                                       data:data
                                                                                                                                                    refresh:refresh
                                                                                                                                                 completion:completion];
                                                         
                                                         [[PTEQueueManager sharedInstance].queue addOperation:operation];
                                                     });
                                  }];
    
    [task resume];
}

@end
