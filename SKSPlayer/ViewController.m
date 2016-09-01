//
//  ViewController.m
//  SKSPlayer
//
//  Created by KeSen on 8/31/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "LiveItem.h"
#import "UIDevice+KS.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

#define kCellIdentifie @"LiveCell"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController
{
    NSMutableArray<LiveItem *> *_dataArray;
    UITableView *_tableView;
    IJKFFMoviePlayerController *_playerVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubView];
    [self initData];
}

- (void)initData
{
    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *tast = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _dataArray = [LiveItem mj_objectArrayWithKeyValuesArray:dict[@"lives"]];
        
        [_tableView reloadData];
    }];
    [tast resume];
}

- (void)createSubView
{
    _tableView = ({
        CGRect frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight);
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 55;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifie];
        
        [self.view addSubview:tableView];
        
        tableView;
    });
}

#pragma mark - tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

#pragma mark - tableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifie];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifie];
    }
    
    LiveItem *item = _dataArray[indexPath.row];
    cell.textLabel.text = item.creator.nick;
    
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",item.creator.portrait]];
    [cell.imageView sd_setImageWithURL:imageUrl
                      placeholderImage:[UIImage imageNamed:@"placeHold"]
                               options:SDWebImageCacheMemoryOnly];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _playerVc = ({
        LiveItem *item = _dataArray[indexPath.row];
        IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:item.streamAddr] withOptions:nil];
        playerVc.view.frame = [UIScreen mainScreen].bounds;
        [self.view addSubview:playerVc.view];
        [playerVc prepareToPlay];
        playerVc;
    });
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_playerVc.view addGestureRecognizer:tap];
}

- (void)tap
{
    [_playerVc pause];
    [_playerVc stop];
    [_playerVc.view removeFromSuperview];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_playerVc pause];
    [_playerVc stop];
}


@end
