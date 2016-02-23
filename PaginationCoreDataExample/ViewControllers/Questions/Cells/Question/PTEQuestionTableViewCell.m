//
//  PTEQuestionTableViewCell.m
//  PaginationThrowAwayExample
//
//  Created by Boles on 11/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "PTEQuestionTableViewCell.h"

#import <PureLayout/PureLayout.h>

@interface PTEQuestionTableViewCell ()

@property (nonatomic, strong, readwrite) UILabel *questionLabel;

@property (nonatomic, strong, readwrite) UILabel *authorLabel;

@end

@implementation PTEQuestionTableViewCell

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self.contentView addSubview:self.questionLabel];
        [self.contentView addSubview:self.authorLabel];
    }
    
    return self;
}

#pragma mark - SubViews

- (UILabel *)questionLabel
{
    if (!_questionLabel)
    {
        _questionLabel = [UILabel newAutoLayoutView];
        _questionLabel.numberOfLines = 2;
        _questionLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    }
    
    return _questionLabel;
}

- (UILabel *)authorLabel
{
    if (!_authorLabel)
    {
        _authorLabel = [UILabel newAutoLayoutView];
        _authorLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    
    return _authorLabel;
}

#pragma mark - Layout

- (void)updateConstraints
{
    [self.questionLabel autoPinEdge:ALEdgeLeft
                             toEdge:ALEdgeLeft
                             ofView:self.contentView
                         withOffset:10.0f];
    
    [self.questionLabel autoPinEdge:ALEdgeTop
                             toEdge:ALEdgeTop
                             ofView:self.contentView
                         withOffset:8.0f];
    
    [self.questionLabel autoPinEdge:ALEdgeRight
                             toEdge:ALEdgeRight
                             ofView:self.contentView
                         withOffset:-10.0f];
    
    /*---------------------*/
    
    [self.authorLabel autoPinEdge:ALEdgeLeft
                           toEdge:ALEdgeLeft
                           ofView:self.contentView
                       withOffset:10.0f];
    
    [self.authorLabel autoPinEdge:ALEdgeBottom
                           toEdge:ALEdgeBottom
                           ofView:self.contentView
                       withOffset:-5.0f];
    
    [self.authorLabel autoPinEdge:ALEdgeRight
                           toEdge:ALEdgeRight
                           ofView:self.contentView
                       withOffset:-10.0f];
    
    /*---------------------*/
    
    [super updateConstraints];
}

- (void)layoutByApplyingConstraints
{
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Identifier

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

@end
