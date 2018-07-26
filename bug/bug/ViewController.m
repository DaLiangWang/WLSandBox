//
//  ViewController.m
//  bug
//
//  Created by 王亮 on 2018/7/20.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "ViewController.h"
#import "WLDEBUGViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [WLDEBUGViewController beginDebug];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    WLGroupDebugView *m = [[WLGroupDebugView alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    [WLDEBUGViewController showView];
////    NSArray *arr = @[];
////    NSString *ss = [arr objectAtIndex:3];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
