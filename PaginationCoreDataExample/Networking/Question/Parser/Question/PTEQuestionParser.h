//
//  PTEQuestionParse.h
//  PaginationThrowAwayExample
//
//  Created by William Boles on 15/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTEQuestion;
@class PTEPage;

@interface PTEQuestionParser : NSObject

- (PTEPage *)parseQuestions:(NSDictionary *)questionsRetrievalReponse;

- (PTEQuestion *)parseQuestion:(NSDictionary *)questionsReponse;

@end
