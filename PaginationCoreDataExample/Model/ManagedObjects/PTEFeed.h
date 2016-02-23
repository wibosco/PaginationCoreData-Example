//
//  PTEFeed.h
//  PaginationCoreDataExample
//
//  Created by William Boles on 23/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * kPTEBaseURLString;

@interface PTEFeed : NSManagedObject

@property (nonatomic, strong, readonly) NSArray *orderedPages;

+ (PTEFeed *)questionFeed;

@end

NS_ASSUME_NONNULL_END

#import "PTEFeed+CoreDataProperties.h"
