//
//  WLDEBUGViewController.m
//  bug
//
//  Created by 王亮 on 2018/7/20.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "WLDEBUGViewController.h"
#import "NSObject+WLDEBUGVC.h"
#import "WLGroupDebugView.h"
#import "CatchExceptionTool.h"
#import "WLCatchViewController.h"

@interface WLDEBUGViewController ()

@end

@implementation WLDEBUGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavButton];

    // Do any additional setup after loading the view from its nib.
}
+ (void)beginDebug{
    [[CatchExceptionTool shareInstance] installUncaughtExceptionHandler];

    
    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(111, 111, 0, 0);
//    label.center = [UIApplication sharedApplication].keyWindow.center;
    
    label.backgroundColor = [UIColor grayColor];
    label.text = @"TEST";
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = [UIColor darkGrayColor];
    [label sizeToFit];
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gotoView:)];
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:gesture];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    
}
+ (void)gotoView:(UITapGestureRecognizer*)gesture{
    if (gesture.state == UIGestureRecognizerStateRecognized){
        [WLDEBUGViewController showView];
    }
}

- (IBAction)shahe:(id)sender {
    WLGroupDebugView *v = [[WLGroupDebugView alloc]init];
    [self.navigationController pushViewController:v animated:YES];
}
- (IBAction)catch:(id)sender {
    WLCatchViewController *v = [[WLCatchViewController alloc]init];
    [self.navigationController pushViewController:v animated:YES];
}

-(void)addNavButton{
    NSMutableArray *items = [NSMutableArray array];
    {
        UIButton *back = [[UIButton alloc]init];
        [back setTitle:@"关闭" forState:UIControlStateNormal];
        [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        back.tag = 0;
        [back addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:back];
        [items addObject:item];
    }
    self.navigationItem.leftBarButtonItems = items;
}
-(void)right_click:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)showView{
    WLDEBUGViewController *showView = [[WLDEBUGViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:showView];
    [[showView topDebugViewController_wl] presentViewController:nav animated:YES completion:nil];
}

@end
