//
//  ViewController.m
//  animatechecker
//
//  Created by qwater on 2018/4/25.
//  Copyright © 2018年 qwater. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *game_bg = [UIImage imageNamed:@"board"];
    UIImageView *game_bg_view = [[UIImageView alloc] initWithImage:game_bg];
    [self.view addSubview:game_bg_view];
    CGSize size = game_bg.size;
    
    int swidth = self.view.frame.size.width;
    int sheight = self.view.frame.size.height;
    int iheight = sheight/(size.width/swidth);
    game_bg_view.frame = CGRectMake(0, (sheight-iheight)/2, swidth, iheight);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
