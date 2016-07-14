//
//  ViewController.m
//  GraphicsAndAnimation
//
//  Created by boolean on 16/7/8.
//  Copyright © 2016年 boolean. All rights reserved.
//

#import "ViewController.h"
#import "UtilsMacro.h"
#import "GraphicsVC.h"
#import "SystemFontsVC.h"
static NSString *const kIdentifier = @"cellIdentifier";
@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIToolbarDelegate
>
@property(nonatomic,strong)GraphicsVC *graphicsVC;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *rowTitleArray;
//@property(nonatomic,strong)NSMutableArray *sectionTitleArray;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.sectionTitleArray addObjectsFromArray:@[@"枚举和加载字体",@"绘制文本",@"构造,设置和使用颜色",@"绘制图像",@"构造可伸缩图片",@"画线",@"构造路径",@"绘制矩形",@"为形状增加阴影",@"绘制渐变",@"移动图形环境上所绘制的形状",@"缩放绘制到图形环境上的形状",@"旋转绘制在图形环境上的形状",@"动画之视图的移动",@"动画之视图的缩放",@"动画之视图的旋转"]];
    [self.rowTitleArray addObjectsFromArray:@[@"枚举和加载字体",@"绘制文本",@"构造,设置和使用颜色",@"绘制图像",@"构造可伸缩图片",@"画线",@"构造路径",@"绘制矩形",@"为形状增加阴影",@"绘制渐变",@"移动图形环境上所绘制的形状",@"缩放绘制到图形环境上的形状",@"旋转绘制在图形环境上的形状",@"动画之视图的移动",@"动画之视图的缩放",@"动画之视图的旋转"]];
    
    self.navigationItem.title = @"图形和动画";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 25.0;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSString *title = self.rowTitleArray[row];
    UIViewController *vc = nil;
    if (row == 0)
    {
        SystemFontsVC *con = [[SystemFontsVC alloc] init];
        vc = con;
    }
    else if (row == 13 ||
             row == 14 ||
             row == 15)
    {
       
    }
    else
    {
        GraphicsVC *con = [[GraphicsVC alloc] init];
        vc = con;
    }
    
    if (vc)
    {
        vc.navigationItem.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return indexPath.row;
//}

#pragma mark - UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return self.sectionTitleArray.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.rowTitleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier forIndexPath:indexPath];
    
    NSString *title = self.rowTitleArray[indexPath.row];
    //cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@",(long)indexPath.row,title];
    return cell;
}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *sectionTitle = self.sectionTitleArray[section];
//    return sectionTitle;
//}
#pragma mark - Getter And Setter
- (UITableView *)table
{
    if (!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                              style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:kIdentifier];
        
    }
    return _table;
}

- (NSMutableArray *)rowTitleArray
{
    if (!_rowTitleArray)
    {
        _rowTitleArray = [[NSMutableArray alloc] init];
    }
    return _rowTitleArray;
}
//- (NSMutableArray *)sectionTitleArray
//{
//    if (!_sectionTitleArray)
//    {
//        _sectionTitleArray = [[NSMutableArray alloc] init];
//    }
//    return _sectionTitleArray;
//}
@end
