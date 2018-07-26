//
//  WLCatchViewController.m
//  bug
//
//  Created by 王亮 on 2018/7/20.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "WLCatchViewController.h"
#import "CatchExceptionTool.h"
#import "CatchExceptionModel.h"

@interface WLCatchViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_topic;
}
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation WLCatchViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setTableFooterView:[UIView new]];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"WLGroupDebugViewCell"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavButton];
    
    [self.view addSubview:self.tableView];
    [self newData];
}

-(void)addNavButton{
    {
    NSMutableArray *items = [NSMutableArray array];
    {
        UIButton *back = [[UIButton alloc]init];
        [back setTitle:@"关闭" forState:UIControlStateNormal];
        [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        back.tag = 0;
        [back addTarget:self action:@selector(left_click:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:back];
        [items addObject:item];
    }
    
    self.navigationItem.leftBarButtonItems = items;
    }
    
    {
        NSMutableArray *items = [NSMutableArray array];
        {
            UIButton *back = [[UIButton alloc]init];
            [back setTitle:@"全删" forState:UIControlStateNormal];
            [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            back.tag = 0;
            [back addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:back];
            [items addObject:item];
        }
        self.navigationItem.rightBarButtonItems = items;
    }
}
-(void)left_click:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)right_click:(UIButton *)sender{
    [[CatchExceptionTool shareInstance] clearAllLog];
    _topic = [NSMutableArray array];
    [self.tableView reloadData];
}


-(void)newData{
    _topic = [NSMutableArray arrayWithArray:[[CatchExceptionTool shareInstance]readExceptionInfoFromLocal]];
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _topic.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WLGroupDebugViewCell"];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WLGroupDebugViewCell"];
    }
    CatchExceptionModel *model = [_topic objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    NSString *text = [NSString stringWithFormat:@"---%@---\n---%@---\n%@\n",model.name,model.time,model.reason];
    cell.textLabel.text = text;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;

//    cell.detailTextLabel.numberOfLines = 0;
//    cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
//    cell.detailTextLabel.text = [model.cellStack componentsJoinedByString:@"\n"];
    return cell;
}

//首先设置cell可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//设置编辑的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";  //我这里需要设置成“取消收藏”而不是“删除”,文字可以自定义
}
//设置进入编辑状态的时候，cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
//点击删除的实现。特别提醒：必须要先删除了数据，才能再执行删除的动画或者其他操作，不然会引起崩溃。
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf removeCellIndexPath:indexPath];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)removeCellIndexPath:(NSIndexPath *)indexPath{
    [[CatchExceptionTool shareInstance] removeExceptionItemIndex:indexPath.row];
    [_topic removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
    CatchExceptionModel *model = [_topic objectAtIndex:indexPath.row];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"name"] = model.name;
    dic[@"reason"] = model.reason;
    dic[@"time"] = model.time;
    dic[@"cellStack"] = model.cellStack;

    
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    pastboard.string = jsonString;
}



@end
