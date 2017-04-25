//
//  XIU_DrawViewController.m
//  图画版
//
//  Created by A-XIU on 2017/4/17.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_DrawViewController.h"
#import "ViewController.h"
@interface XIU_DrawViewController ()

@end

@implementation XIU_DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 50, 175, 40);
    [button setTitle:@"22" forState:UIControlStateNormal];
    button.layer.borderWidth = 2.0;
    button.layer.cornerRadius = 5.0;
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickedButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)didClickedButton {
    ViewController *v = [[ViewController alloc] init];
    [self.navigationController pushViewController:v animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
