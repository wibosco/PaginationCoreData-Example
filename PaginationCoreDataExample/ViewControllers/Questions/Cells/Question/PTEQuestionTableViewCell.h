//
//  PTEQuestionTableViewCell.h
//  PaginationThrowAwayExample
//
//  Created by Boles on 11/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTEQuestionTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) UILabel *questionLabel;

@property (nonatomic, strong, readonly) UILabel *authorLabel;

+ (NSString *)reuseIdentifier;

- (void)layoutByApplyingConstraints;

@end
