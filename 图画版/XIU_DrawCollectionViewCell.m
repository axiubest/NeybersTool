//
//  XIU_DrawCollectionViewCell.m
//  图画版
//
//  Created by A-XIU on 2017/4/15.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_DrawCollectionViewCell.h"

@interface XIU_DrawCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *topBgView;

@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@end

@implementation XIU_DrawCollectionViewCell

- (IBAction)clickAddBtn:(id)sender {
//    [_Delegate clcikAddBtnDelegate];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"XIU_DrawCollectionViewCellNoti" object:nil userInfo:nil];
    
}

- (IBAction)clickLikeBtn:(id)sender {
    if ([sender isSelected]) {
        [_likeBtn setImage:[UIImage imageNamed:@"unlike"] forState:UIControlStateNormal];
        
    }else {
        [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }
    _likeBtn.selected = !_likeBtn.selected;


}

- (void)awakeFromNib {
    [super awakeFromNib];
    _topImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clcikImageView)];
    [_topImageView addGestureRecognizer:tapImage];
    CALayer *line = [CALayer layer];
    line.backgroundColor = [UIColor lightGrayColor].CGColor;
    line.frame = CGRectMake(0, _topBgView.frame.size.height - 0.5, _topBgView.frame.size.width, .5);
    [self.layer addSublayer:line];
    
    self.layer.borderWidth = .5f;
    self.layer.borderColor  =[UIColor lightGrayColor].CGColor
    ;
    

}

- (void)clcikImageView {
    [_Delegate clcikImageViewDelegate];
}
@end
