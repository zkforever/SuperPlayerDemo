//
//  TXPlayerViewController.m
//  TXLiteAVDemo_Player
//
//  Created by jinxixin on 2020/9/28.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "TXPlayerViewController.h"
#import <Masonry/Masonry.h>
#import <SuperPlayer/SuperPlayer.h>
//#import " TXMoviePlayerNetApi.h"
#import "CheckControlView.h"
#import "UIView+Fade.h"


@interface TXPlayerViewController ()<SuperPlayerDelegate>

@property (nonatomic) UIView *playerFatherView;
@property (strong, nonatomic) SuperPlayerView *playerView;


@end

@implementation TXPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self playURL];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.playerView resetPlayer];
}

- (void)playURL {
    SuperPlayerModel *playerModel = [[SuperPlayerModel alloc] init];
    playerModel.videoURL         = @"http://125.210.152.18:9090/live/BJWSHD_H265.m3u8";
    [self.playerView playWithModel:playerModel];
    [self.playerView.controlView setTitle:@"aa"];
    [self showControlView:YES];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.playerFatherView = [[UIView alloc] init];
    self.playerFatherView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.playerFatherView];
    [self.playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(20+self.navigationController.navigationBar.bounds.size.height);
        }
        make.leading.trailing.mas_equalTo(0);
        // 这里宽高比16：9,可自定义宽高比
        make.height.mas_equalTo(self.playerFatherView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    
    self.playerView.fatherView = self.playerFatherView;
}


//- (void)onNetSuccess:(TXMoviePlayInfoResponse *)playInfo
//{
//  
//}

- (void)hudMessage:(NSString *)msg {
    
}

//- (void)onNetFailed:(TXMoviePlayerNetApi *)obj reason:(NSString *)reason code:(int)code {
//    [self hudMessage:@"fileid请求失败"];
//}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


- (void)showControlView:(BOOL)isShow {
    if (isShow) {
        self.playerView.controlView.hidden = NO;
    } else {
        self.playerView.controlView.hidden = YES;
    }
//    self.playerView.controlView.hidden = YES;

}


// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 这里设置横竖屏不同颜色的statusbar
    // if (SuperPlayerShared.isLandscape) {
    //    return UIStatusBarStyleDefault;
    // }
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return self.playerView.isFullScreen;
}


- (void)superPlayerFullScreenChanged:(SuperPlayerView *)player {
    [[UIApplication sharedApplication] setStatusBarHidden:player.isFullScreen];
//    self.navigationController.navigationBarHidden = player.isFullScreen;
//    if (player.isFullScreen) {
//        self.playerView.fatherView = self.playerFullFatherView;
//        self.playerFullFatherView.hidden = NO;
//        self.playerFatherView.hidden = YES;
//    }else{
//        self.playerView.fatherView = self.playerFatherView;
//        self.playerFullFatherView.hidden = YES;
//        self.playerFatherView.hidden = NO;
//    }
}

- (void)superPlayerDidEnd:(SuperPlayerView *)player
{

}

- (void)superPlayerDidStart:(SuperPlayerView *)player
{

}


- (SuperPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[SuperPlayerView alloc] init];
        SuperPlayerWindowShared;
        _playerView.fatherView = _playerFatherView;
        // 设置代理
        _playerView.delegate = self;
        _playerView.controlView = [CheckControlView new];
        // demo的时移域名，请根据您项目实际情况修改这里
    }
    return _playerView;
}

@end
