//
//  XIU_EditorToolView.m
//  图画版
//
//  Created by A-XIU on 2017/4/9.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_EditorToolView.h"
@interface XIU_EditorToolView ()<UIScrollViewDelegate,XIU_EditorPerspecitiveDelgate,XIU_EditorFilterDelgate>


@property (nonatomic, weak)UIScrollView *scrollView;

@property (nonatomic, weak) UIViewController *controller;
@property (nonatomic,strong) NSArray <NSString *>*toolBarArr;
@end
NSInteger toolBarItemSize = 60;
@implementation XIU_EditorToolView
@synthesize style = _style;

-(NSArray<NSString *> *)toolBarArr {
    if (!_toolBarArr) {
        _toolBarArr = @[@"DELETE",@"FORWARD",@"BACK",@"FLIP",@"CLONE",@"FILTER",@"CROP",@"PERSPECTIVE",@"LOCK",@"INFO"];
    }
    return _toolBarArr;
}

-(XIU_EditorPerspecitiveView *)perspecitive {
    if (!_perspecitive) {
        XIU_EditorPerspecitiveView *perspecitive = [[[NSBundle mainBundle] loadNibNamed:@"XIU_EditorPerspecitiveView" owner:nil options:nil] firstObject];
        perspecitive.delegate = self;
        perspecitive.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 180);
        _perspecitive = perspecitive;
    }
    return _perspecitive;
}

- (XIU_EditorFilterView *)filter {
    if (!_filter) {
        XIU_EditorFilterView *filter = [[[NSBundle mainBundle] loadNibNamed:@"XIU_EditorFilterView" owner:nil options:nil] firstObject];
        filter.delegate = self;
        filter.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 180);
        _filter = filter;
  
    }
   return _filter;
}


#pragma mark perspecitive-Delegate
- (void)perspecitiveValueChangeOfHorizontalWithValue:(CGFloat)value {
    [self valueChangeWithType:EditorToolStyle_Perspecitive Value:value];
}
- (void)perspecitiveValueChangeOfVerticalWithValue:(CGFloat)value {
    [self valueChangeWithType:EditorToolStyle_Perspecitive Value:value];
}

#pragma mark filter-Delegate
- (void)filterValueChangeOfHorizontalWithValue:(CGFloat)value {
        [self valueChangeWithType:EditorToolStyle_Filter Value:value];
}
- (void)filterValueChangeOfVerticalWithValue:(CGFloat)value {
      [self valueChangeWithType:EditorToolStyle_Filter Value:value];
}

- (void)valueChangeWithType:(EditorToolStyle)type Value:(CGFloat)value {
    NSDictionary *dic = @{@"type":[NSNumber numberWithInteger:type],@"value":[NSNumber numberWithFloat:value]};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"texttext" object:nil userInfo:dic];
}

-(instancetype)initWithFrame:(CGRect)frame  Controller:(UIViewController *)controller{
    self = [super initWithFrame:frame];
    if (self) {
        _controller = controller;
        self.backgroundColor = [UIColor whiteColor];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.backgroundColor = [UIColor clearColor];
        _scrollView = scrollView;
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(self.toolBarArr.count * (toolBarItemSize + 10) - 10, toolBarItemSize);
        
        [self addSubview:scrollView];

        for (int i = 0; i < self.toolBarArr.count; i++) {
            UIButton *edit = [[UIButton alloc] initWithFrame:CGRectMake(i * 70, 0, toolBarItemSize, toolBarItemSize)];
            edit.titleLabel.font = [UIFont systemFontOfSize:10];
            edit.backgroundColor = [UIColor orangeColor];
            [edit setTitle:self.toolBarArr[i] forState:UIControlStateNormal];
            edit.tag = i;
            [edit addTarget:self action:@selector(clcikBotton:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:edit];
            [self.scrollView addSubview:edit];
        }

        [self createToolBarView];

    }
    return self;

}

- (void)createToolBarView {
    [self addSubview:self.perspecitive];
    [self addSubview:self.filter];
}

- (void)clcikBotton:(UIButton *)sender {
    switch (sender.tag) {
        case EditorToolStyle_Clone:
                [[NSNotificationCenter defaultCenter]postNotificationName:@"texttext" object:nil userInfo:@{@"type":[NSNumber numberWithInteger:EditorToolStyle_Clone]}];
            _style = EditorToolStyle_Clone;
                break;
        case EditorToolStyle_Delete:
               [[NSNotificationCenter defaultCenter]postNotificationName:@"texttext" object:nil userInfo:@{@"type":[NSNumber numberWithInteger:EditorToolStyle_Delete]}];
                break;
        case EditorToolStyle_Filter: {
            [UIView animateWithDuration:.5f animations:^{
                self.filter.frame = CGRectMake(0, self.frame.size.height - 170, self.frame.size.width, 170);
            }];
        }

                break;
            case EditorToolStyle_Lock:
                
                break;
            case EditorToolStyle_Info:
                
                break;
                case EditorToolStyle_Perspecitive:{
                    [UIView animateWithDuration:.5 animations:^{
                        self.perspecitive.frame = CGRectMake(0, self.frame.size.height - 170, self.frame.size.width, 170);
                    }];
                }
                       break;
            case EditorToolStyle_Flip:
                
                break;
            case EditorToolStyle_Crop:
                [[NSNotificationCenter defaultCenter]postNotificationName:@"texttext" object:nil userInfo:@{@"type":[NSNumber numberWithInteger:EditorToolStyle_Crop]}];
                break;
            default:
                break;
            }
    
    //tool drawView communication
//    NSDictionary *dic = @{@"type":[NSNumber numberWithInteger:sender.tag],@"value":@10};
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"texttext" object:nil userInfo:dic];
}




@end
