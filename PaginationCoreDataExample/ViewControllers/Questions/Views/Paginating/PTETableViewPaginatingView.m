//
//  PTETableViewPaginatingView.m
//  PaginationThrowAwayExample
//
//  Created by Home on 21/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "PTETableViewPaginatingView.h"

#import <PureLayout/PureLayout.h>

@interface PTETableViewPaginatingView ()

@property (nonatomic, strong, readwrite) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation PTETableViewPaginatingView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self addSubview:self.activityIndicatorView];
        
        [self updateConstraints];
    }
    
    return self;
}

#pragma mark - SubViews

- (UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView)
    {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    
    return _activityIndicatorView;
}

#pragma mark - Constraints

- (void)updateConstraints
{
    [self.activityIndicatorView autoCenterInSuperview];
    
    /*---------------------*/
    
    [super updateConstraints];
}

@end
