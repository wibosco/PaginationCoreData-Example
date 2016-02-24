//
//  PTEQuestionsRetrievalOperation.h
//  PaginationThrowAwayExample
//
//  Created by William Boles on 15/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class PTEFeed;

@interface PTEQuestionsRetrievalOperation : NSOperation

- (instancetype)initWithFeedID:(NSManagedObjectID *)feedID
                          data:(NSData *)data
                       refresh:(BOOL)refresh
                    completion:(void(^)(BOOL successful))completion;

@end
