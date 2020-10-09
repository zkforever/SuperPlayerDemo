//
//  ViewController.m
//  SuperPlayerDemo
//
//  Created by jinxixin on 2020/9/30.
//  Copyright © 2020 com.jxx.test. All rights reserved.
//

#import "ViewController.h"
#import <SuperPlayer/SuperPlayer.h>
#import "TXPlayerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnAAAction:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)btnAAAction:(UIButton*)btn {
    TXPlayerViewController *vc = [TXPlayerViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
