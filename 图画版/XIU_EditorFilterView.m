//
//  XIU_EditorFilterView.m
//  图画版
//
//  Created by A-XIU on 2017/5/3.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_EditorFilterView.h"

@implementation XIU_EditorFilterView


- (void)hiddenEditorPersperitiveWithAnimation:(BOOL)animation {
    if (animation) {
        [UIView animateWithDuration:.5f animations:^{
            self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 180);
        }];
        
    }else {
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 180);
    }
}

- (IBAction)clickReset:(id)sender {
    
}


- (IBAction)clickChanel:(id)sender {
    [self hiddenEditorPersperitiveWithAnimation:YES];
}

- (IBAction)clickSure:(id)sender {
    [self hiddenEditorPersperitiveWithAnimation:YES];
    
}

- (IBAction)horizontalSliderValueChange:(UISlider *)sender {
    [_delegate filterValueChangeOfHorizontalWithValue:sender.value];
}
- (IBAction)verticalSliderValueChange:(UISlider *)sender {
    [_delegate filterValueChangeOfVerticalWithValue:sender.value];
}

@end
