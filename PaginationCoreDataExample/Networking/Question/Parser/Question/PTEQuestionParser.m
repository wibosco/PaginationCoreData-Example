//
//  PTEQuestionParse.m
//  PaginationThrowAwayExample
//
//  Created by William Boles on 15/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "PTEQuestionParser.h"

#import <CoreDataServices/NSEntityDescription+CDSEntityDescription.h>
#import <CoreDataServices/CDSServiceManager.h>

#import "PTEQuestion.h"
#import "PTEPage.h"

@implementation PTEQuestionParser

#pragma mark - Parse

- (PTEPage *)parseQuestions:(NSDictionary *)questionsRetrievalReponse
{
    PTEPage *page = [NSEntityDescription cds_insertNewObjectForEntityForClass:[PTEPage class]
                                                       inManagedObjectContext:[CDSServiceManager sharedInstance].backgroundManagedObjectContext];
    
    NSArray *questionsReponse = questionsRetrievalReponse[@"items"];
    
    for (NSUInteger index = 0; index < questionsReponse.count; index++)
    {
        NSDictionary *questionResponse = questionsReponse[index];
        
        PTEQuestion *question = [self parseQuestion:questionResponse];
        question.index = @(index);
        
        [page addQuestionsObject:question];
    }
    
    return page;
}

- (PTEQuestion *)parseQuestion:(NSDictionary *)questionReponse
{
    PTEQuestion *question = [NSEntityDescription cds_insertNewObjectForEntityForClass:[PTEQuestion class]
                                                               inManagedObjectContext:[CDSServiceManager sharedInstance].backgroundManagedObjectContext];
    
    NSDictionary *ownerResponse = questionReponse[@"owner"];
    
    question.author = ownerResponse[@"display_name"];
    question.title = questionReponse[@"title"];
    
    return question;
}

@end
