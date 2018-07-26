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
#import "WLSingleCase.h"
#
#import "WLDEBUGHeader.h"
@interface WLDEBUGViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *showTouchTagSwitch;

@end

@implementation WLDEBUGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavButton];

    [self.showTouchTagSwitch setOn:[WLSingleCase shareInstance].isShowTouchTagView];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)changeShowTouchTag:(UISwitch *)sender {
    [WLSingleCase shareInstance].isShowTouchTagView = sender.isOn;
    [[WLSingleCase shareInstance].showTouchTagView removeFromSuperview];
}
+ (void)beginDebug{
    [[CatchExceptionTool shareInstance] installUncaughtExceptionHandler];
    [WLSingleCase shareInstance].isShowTouchTagView = YES;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        UILabel *label = [[UILabel alloc]init];
        
        label.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, 15, 49);
//        label.backgroundColor = [UIColor ];
        label.text = @"T\nE\nS\nT";
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = [UIColor darkGrayColor];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        
        
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gotoView:)];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:gesture];
        
        [keyWindows_wl addSubview:label];
    });
    
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
