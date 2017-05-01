//
//  XIU_DrawAddItemViewController.m
//  图画版
//
//  Created by A-XIU on 2017/4/13.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_DrawAddItemViewController.h"
#import "XIU_DrawAddItemHeaderView.h"//header view
#import "Masonry.h"
#import "XIU_DrawCollectionViewCell.h"
@interface XIU_DrawAddItemViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,XIU_DrawCollectionViewCellDelegate>

@property (nonatomic, weak) XIU_DrawAddItemHeaderView *headerView;

@end

@implementation XIU_DrawAddItemViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    XIU_DrawAddItemHeaderView *header = [[XIU_DrawAddItemHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 100, 60)];
    _headerView = header;
    [self.view addSubview:_headerView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 5;
    layout.itemSize = CGSizeMake(90, 120);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60,self.view.frame.size.width - 100, self.view.frame.size.height - 60)collectionViewLayout:layout];
    collection.dataSource = self;
    collection.delegate = self;
    collection.pagingEnabled = YES;
    collection.userInteractionEnabled = YES;
    collection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collection];
    [collection registerNib:[UINib nibWithNibName:@"XIU_DrawCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XIU_DrawCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.Delegate = self;
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}

- (void)clcikImageViewDelegate {
    [_delegate drawAddItem];

}

@end
