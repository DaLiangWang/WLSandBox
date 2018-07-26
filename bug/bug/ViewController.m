//
//  ViewController.m
//  bug
//
//  Created by 王亮 on 2018/7/20.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "ViewController.h"
#import "WLDEBUGViewController.h"
#import "WLView.h"

@interface ViewController ()

@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    WLView *views = [[WLView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    views.backgroundColor = [UIColor redColor];
    [self.view addSubview:views];
//    WLGroupDebugView *m = [[WLGroupDebugView alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"4321");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
