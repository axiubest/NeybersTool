//
//  ViewController.m
//  图画版
//
//  Created by A-XIU on 2017/4/9.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "ViewController.h"
#import "XIU_EditorToolView.h"
#import "XIU_DrawView.h"
#import "XIU_DrawAddItemViewController.h"

#define Width self.view.frame.size.width
#define Height self.view.frame.size.height

@interface ViewController ()<XIU_EditorToolDelegate,XIU_DrawAddItemVCDelegate>

@property (nonatomic, weak)XIU_DrawView *drawView;
@property (nonatomic, weak)XIU_EditorToolView *editorToolView;
@property (nonatomic, weak)UIView *bgView;
@property (nonatomic, weak)UIButton *pushBtn;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.hidden = YES;
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ClickAddBtn) name:@"XIU_DrawCollectionViewCellNoti" object:nil];
    
    XIU_DrawAddItemViewController *itemVC = [[XIU_DrawAddItemViewController alloc] init];
    itemVC.view.frame = CGRectMake(100, 0, self.view.frame.size.width - 100, self.view.frame.size.height);
    itemVC.delegate = self;
    [self.view insertSubview:itemVC.view belowSubview:self.view];
    [self addChildViewController:itemVC];

  

    UIView *bgView = [[UIView alloc] initWithFrame:self.view.frame];
    _bgView = bgView;
    bgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bgView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(Width - 100, 50, 100, 40);
    [button setTitle:@"xx" forState:UIControlStateNormal];
    button.layer.borderWidth = 2.0;
    button.layer.cornerRadius = 5.0;
    button.layer.masksToBounds = YES;
    _pushBtn = button;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.selected = NO;
    [button addTarget:self action:@selector(didClickedButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:button];
    
    XIU_EditorToolView *view = [[XIU_EditorToolView alloc] initWithFrame:CGRectMake(0, Height - 60, Width, 60) Controller:self];
    view.delegate = self;
    _editorToolView = view;
    XIU_DrawView *draw = [[XIU_DrawView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)Controller:self];
    draw.center = self.view.center;
    _drawView = draw;

    [bgView addSubview:self.drawView];
    [bgView addSubview:view];
    
    
}

- (void)didClickedButton:(UIButton *)sender {
    if (!sender.selected) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clcikItemBtn)];
        
        [_bgView addGestureRecognizer:tap];
        [UIView animateWithDuration:0.5 animations:^{
            _bgView.frame = CGRectMake(100 - Width, 0, Width, Height);
        }];
        sender.selected = YES;
    }else {
        sender.selected = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _bgView.frame = CGRectMake(0, 0, Width, Height);
        }];
    }
   }


- (void)drawAddItem {
    [UIView animateWithDuration:0.5 animations:^{
        _bgView.frame = CGRectMake(0, 0, Width, Height);
    }];
    [self.drawView createNewViewWithImage:[UIImage imageNamed:@"char"]];
    

}

- (void)clcikItemBtn {
    [UIView animateWithDuration:0.5 animations:^{
        _bgView.frame = CGRectMake(0, 0, Width, Height);
    }];
}




- (void)ClickAddBtn {
    _pushBtn.selected = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _bgView.frame = CGRectMake(0, 0, Width, Height);
    }];

}

#pragma mark----Delegate
- (void)editorToolClone {
    
}
- (void)editorToolPerspecitive {
    [self editorToolPerspecitiveViewHidden];
}





- (void)editorToolPerspecitiveViewHidden {
    [UIView animateWithDuration:.5 animations:^{
        _editorToolView.perspecitive.frame = CGRectMake(0, self.view.frame.size.height - 170, self.view.frame.size.width, 170);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
