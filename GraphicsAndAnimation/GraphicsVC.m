//
//  GraphicsVC.m
//  GraphicsAndAnimation
//
//  Created by boolean on 16/7/8.
//  Copyright © 2016年 boolean. All rights reserved.
//

#import "GraphicsVC.h"
#import "GraphicsAndAnimationView.h"

@implementation GraphicsVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addUI];
}
#pragma mark - UI
- (void)addUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    GraphicsAndAnimationView *view = [[GraphicsAndAnimationView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.title = self.navigationItem.title;
    view.frame = self.view.bounds;
    [self.view addSubview:view];
}
@end
