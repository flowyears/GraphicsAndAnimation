//
//  SystemFontsVC.m
//  GraphicsAndAnimation
//
//  Created by boolean on 16/7/9.
//  Copyright © 2016年 boolean. All rights reserved.
//

#import "SystemFontsVC.h"
#import "UtilsMacro.h"
static NSString *const kIdentifier = @"cellIdentifier";

@interface SystemFontsVC ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *rowTitleArray;
@property(nonatomic,strong)NSMutableArray *sectionTitleArray;
@end
@implementation SystemFontsVC
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"系统字体";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.table];
    [self enumerateFonts];
}
#pragma mark - Method
- (void)enumerateFonts
{
    for (NSString *familyName in [UIFont familyNames])
    {
         [self.sectionTitleArray addObject:familyName];
        NSMutableArray *mArr = [[NSMutableArray alloc] init];
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName])
        {
            [mArr addObject:fontName];
        }
        [self.rowTitleArray addObject:mArr];
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.rowTitleArray[section];
    return [arr count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionTitleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier forIndexPath:indexPath];
    
    NSArray *arr = self.rowTitleArray[indexPath.section];
    NSString *title = arr[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:title size:16];
    cell.textLabel.text = title;
    return cell;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = self.sectionTitleArray[section];
    return sectionTitle;
}
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
- (NSMutableArray *)sectionTitleArray
{
    if (!_sectionTitleArray)
    {
        _sectionTitleArray = [[NSMutableArray alloc] init];
    }
    return _sectionTitleArray;
}
@end
