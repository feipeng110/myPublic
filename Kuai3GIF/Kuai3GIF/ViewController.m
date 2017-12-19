//
//  ViewController.m
//  Kuai3GIF
//
//  Created by feipeng on 2017/12/11.
//  Copyright © 2017年 feipeng. All rights reserved.
//

#import "ViewController.h"
#import "Kuai3AnimationView.h"

@interface ViewController ()

@property (nonatomic, strong) Kuai3AnimationView * gifView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    Kuai3AnimationView * GIFView = [[Kuai3AnimationView alloc] init];
//    [GIFView show];
//    [self.view addSubview:GIFView];
}

-(Kuai3AnimationView *)gifView {
    if (!_gifView) {
        _gifView = [[Kuai3AnimationView alloc] init];
    }
    return _gifView;
}

- (IBAction)begin:(id)sender {
    [self.gifView showInView:self.view];
    
    
}

- (IBAction)end:(id)sender {
    [self.gifView stopWithNums:@[@"1", @"5", @"6"] AndfinishBlock:^{
        NSLog(@"%@", @"结束");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
