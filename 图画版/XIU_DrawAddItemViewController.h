//
//  XIU_DrawAddItemViewController.h
//  图画版
//
//  Created by A-XIU on 2017/4/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XIU_DrawAddItemVCDelegate <NSObject>

- (void)drawAddItem;

@end

@interface XIU_DrawAddItemViewController : UIViewController

@property (nonatomic, assign)id<XIU_DrawAddItemVCDelegate>delegate;

@end
