//
//  PTEQuestionsAPIManager.h
//  PaginationThrowAwayExample
//
//  Created by Boles on 11/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTEFeed;

@interface PTEQuestionsAPIManager : NSObject

+ (void)retrievalQuestionsForFeed:(PTEFeed *)feed
                       completion:(void(^)(BOOL successful))completion;

@end
