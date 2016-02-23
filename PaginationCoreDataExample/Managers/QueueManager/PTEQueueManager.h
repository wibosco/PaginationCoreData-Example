//
//  PTEQueueManager.h
//  PaginationThrowAwayExample
//
//  Created by William Boles on 15/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTEQueueManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong, readonly) NSOperationQueue *queue;

@end
