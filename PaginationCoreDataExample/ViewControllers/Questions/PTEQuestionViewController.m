//
//  PTEViewController.m
//  PaginationThrowAwayExample
//
//  Created by Boles on 11/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "PTEQuestionViewController.h"

#import <CoreDataServices/NSEntityDescription+CDSEntityDescription.h>
#import <CoreDataServices/CDSServiceManager.h>

#import "PTEQuestionTableViewCell.h"
#import "PTEQuestionsAPIManager.h"
#import "PTEFeed.h"
#import "PTEPage.h"
#import "PTEQuestion.h"
#import "PTEQuestionsAPIManager.h"
#import "PTETableViewPaginatingView.h"

@interface PTEQuestionViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PTEFeed *feed;

@property (nonatomic, strong) PTETableViewPaginatingView *paginatingView;

@property (nonatomic, assign, getter = isPaginating) BOOL paginating;

- (void)refresh;
- (void)paginate;

@end

@implementation PTEQuestionViewController

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*-------------------*/
    
    self.title = @"Questions";
    
    /*-------------------*/
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refresh];
    
    [self.tableView reloadData];
}

#pragma mark - DataRetrieval

- (void)refresh
{
    __weak typeof(self) weakSelf = self;
    
    [PTEQuestionsAPIManager retrievalQuestionsForFeed:self.feed
                                           completion:^(BOOL successful)
    {
        [weakSelf.tableView reloadData];
    }];
}

- (void)paginate
{
    if (!self.isPaginating)
    {
        self.paginating = YES;
        
        self.tableView.tableFooterView = self.paginatingView;
        
        [self.paginatingView.activityIndicatorView startAnimating];
    }
    
    __weak typeof(self) weakSelf = self;
    
    [PTEQuestionsAPIManager retrievalQuestionsForFeed:self.feed
                                           completion:^(BOOL successful)
     {
         [weakSelf.tableView reloadData];
         
         if (self.isPaginating)
         {
             self.paginating = NO;
             
             self.tableView.tableFooterView = nil;
             
             [self.paginatingView.activityIndicatorView stopAnimating];
         }
     }];
}

#pragma mark - Questions

- (PTEFeed *)feed
{
    if (!_feed)
    {
        _feed = [PTEFeed questionFeed];
        
        if (!_feed)
        {
            _feed = [NSEntityDescription cds_insertNewObjectForEntityForClass:[PTEFeed class]
                                                       inManagedObjectContext:[CDSServiceManager sharedInstance].mainManagedObjectContext];
            
            [[CDSServiceManager sharedInstance] saveMainManagedObjectContext];
        }
    }
    
    return _feed;
}

#pragma mark - Subview

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame
                                                  style:UITableViewStylePlain];
        
        _tableView.rowHeight = 66.0f;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:[PTEQuestionTableViewCell class]
           forCellReuseIdentifier:[PTEQuestionTableViewCell reuseIdentifier]];
    }
    
    return _tableView;
}

- (PTETableViewPaginatingView *)paginatingView
{
    if (!_paginatingView)
    {
        _paginatingView = [[PTETableViewPaginatingView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                       0.0f,
                                                                                       self.tableView.frame.size.width,
                                                                                       60.0f)];
    }
    
    return _paginatingView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.feed.orderedQuestions.count;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    PTEQuestion *question = self.feed.orderedQuestions[indexPath.row];
//    
//    PTEQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PTEQuestionTableViewCell reuseIdentifier]
//                                                                  forIndexPath:indexPath];
//    
//    cell.questionLabel.text = question.title;
//    cell.authorLabel.text = question.author;
//    
//    /*-------------------*/
//    
//    NSUInteger numberOfRowsInSection = [tableView numberOfRowsInSection:indexPath.section];
//    NSUInteger paginationTriggerIndex = numberOfRowsInSection - 10;
//    
//    BOOL triggerPagination = (indexPath.row >= MIN(paginationTriggerIndex, numberOfRowsInSection - 1));
//    
//    if (triggerPagination)
//    {
//        [self paginate];
//    }
//    
//    /*-------------------*/
//    
//    [cell layoutByApplyingConstraints];
//    
//    /*-------------------*/
//    
//    return cell;
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

@end
