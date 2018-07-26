//
//  WLGroupDebugView.m
//  bug
//
//  Created by 王亮 on 2018/7/20.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "WLGroupDebugView.h"
#import "WLGroupDebugFileModel.h"
#import "NSObject+WLDEBUGFileSize.h"

@interface WLGroupDebugView ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_topic;
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *groupPath;

@end
@implementation WLGroupDebugView
-(NSMutableArray *)groupPath{
    if (!_groupPath) {
        _groupPath = [NSMutableArray array];
    }
    return _groupPath;
}
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
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self addNavButton];

    [self newData];
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
    //    {
    //        UIButton *back = [[UIButton alloc]init];
    //        [back setTitle:@"上一级" forState:UIControlStateNormal];
    //        [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //        back.tag = 1;
    //        [back addTarget:self action:@selector(right_click:) forControlEvents:UIControlEventTouchUpInside];
    //        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:back];
    //        [items addObject:item];
    //    }
    
    self.navigationItem.leftBarButtonItems = items;
}
-(void)right_click:(UIButton *)sender{
    if (sender.tag == 0) {
        [self.navigationController popViewControllerAnimated:YES];
//        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if(sender.tag == 1){
        if (self.groupPath.count) {
            [self.groupPath removeLastObject];
            [self newData];
        }
    }
}

-(void)newData{
    NSString *path = groupNewPath(self.groupPath);
    NSArray *arr = [self getSanFileList:path];

    _topic = [NSMutableArray arrayWithArray:arr];
    
    if (self.groupPath.count) {
        WLGroupDebugFileModel *model = [WLGroupDebugFileModel new];
        model.fileDesc = @"返回上一级";
        model.fileName = @"...";
        model.groupDebugFileTouchScheme = WLGroupDebugFileTouchSchemeNona;
        [_topic insertObject:model atIndex:0];
    }
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
    WLGroupDebugFileModel *model = [_topic objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    if (model.groupDebugFileTouchScheme == WLGroupDebugFileTouchSchemeFile) {
        cell.imageView.image = [UIImage imageNamed:@"file_debug_icon.png"];
    }
    if (model.groupDebugFileTouchScheme == WLGroupDebugFileTouchSchemePath) {
        cell.imageView.image = [UIImage imageNamed:@"folder_debug_icon.png"];
    }
    cell.textLabel.text = model.fileOtherName;
    if (model.dataSize) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@",model.fileDesc,model.dataSize];
    }
    else{
        cell.detailTextLabel.text = model.fileDesc;
    }
    return cell;
}

//首先设置cell可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.groupPath.count) {
        return indexPath.row;
    }
    return NO;
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
    WLGroupDebugFileModel *model = [_topic objectAtIndex:indexPath.row];
    if ([self clearFile:model.filePath]) {
        [_topic removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WLGroupDebugFileModel *model = [_topic objectAtIndex:indexPath.row];
    if (model.groupDebugFileTouchScheme == WLGroupDebugFileTouchSchemePath) {
        [self.groupPath addObject:model.fileName];
        [self newData];
    }
    else if (model.groupDebugFileTouchScheme == WLGroupDebugFileTouchSchemeNona){
        [self.groupPath removeLastObject];
        [self newData];
    }
    else{
        if (model.data) {
            NSArray *activityItems = @[model.data];
            UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
            [self presentViewController:activityVC animated:YES completion:nil];
        }
        NSLog(@"点击文件");
    }
}

/** 删除文件 */
- (BOOL)clearFile:(NSString *)path{
    NSString *directoryPath = path;
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
    if (error) {
        return NO;
    }
    else{
        return YES;
    }
}
static inline NSString *homeDirectory() {
    return NSHomeDirectory();
}
static inline NSString *groupNewPath(NSArray *group) {
    NSString * homePath = homeDirectory();
    for (NSString *path in group) {
        homePath  = [homePath stringByAppendingPathComponent:path];
    }
    return homePath;
}
/** 判断路径是否为文件夹 */
- (int)isDir:(NSString *)path{
    NSFileManager * fileManger = [NSFileManager defaultManager];
    /** 设置判断是否为文件夹 */
    BOOL isDir = NO;
    /** 是否成功读取到文件或文件夹 */
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {//读取到文件
        if (isDir) {//是文件夹
            return 1;
        }else{//是文件
            NSLog(@"%@",path);
            return 2;
        }
    }else{//路径不存在
        NSLog(@"路径不存在");
        return 0;
    }
}
/** 获取文件夹内子文件夹列表 */
-(NSArray<WLGroupDebugFileModel *> *)getSanFileList:(NSString *)path{
    NSFileManager * fileManger = [NSFileManager defaultManager];
    NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
    NSMutableArray *FileList = [NSMutableArray array];
    for (NSString * str in dirArray) {
        NSString * subPath  = [path stringByAppendingPathComponent:str];
        BOOL issubDir = NO;
        [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
        
        WLGroupDebugFileModel *model = [WLGroupDebugFileModel new];
        
        model.fileName = str;
        model.filePath = subPath;

        model.groupDebugFileTouchScheme = issubDir?WLGroupDebugFileTouchSchemePath:WLGroupDebugFileTouchSchemeFile;
        
        /** 读取文件信息 */
        NSDictionary *fileAttributes = [fileManger attributesOfItemAtPath:subPath error:nil];

//        model.dataSize = subPath.fileSize;

        if (issubDir) {
            NSArray * issubArray = [fileManger contentsOfDirectoryAtPath:subPath error:nil];
            if (issubArray.count) {
                model.fileDesc = [NSString stringWithFormat:@"文件夹-共%ld个文件",issubArray.count];
            }
            else{
                model.fileDesc = @"没有文件";
            }
            model.dataSize = [self folderSizeAtPath:subPath];
        }
        else{
            /** 创建 文件管理 */
            NSFileManager *fileManager = [NSFileManager defaultManager];
            /** 读取文件 数据 */
            NSData *data = [fileManager contentsAtPath:subPath];
            model.fileDesc = @"文件";
            model.data = data;
            model.dataSize = [self fileSizeAtPath:subPath];
        }
        [FileList addObject:model];
    }
    return FileList;
}



@end
