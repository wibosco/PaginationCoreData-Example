//
//  PTEQueueManager.m
//  PaginationThrowAwayExample
//
//  Created by William Boles on 15/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "PTEQueueManager.h"

@interface PTEQueueManager ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation PTEQueueManager

#pragma mark - SharedInstance

+ (instancetype)sharedInstance
{
    static PTEQueueManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedInstance = [[PTEQueueManager alloc] init];
                  });
    
    return sharedInstance;
}

#pragma mark - Queue

- (NSOperationQueue *)queue
{
    if (!_queue)
    {
        _queue = [[NSOperationQueue alloc] init];
    }
    
    return _queue;
}

@end
