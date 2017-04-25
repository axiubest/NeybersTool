//
//  XIU_DrawView.m
//  图画版
//
//  Created by A-XIU on 2017/4/12.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "XIU_DrawView.h"

@interface XIU_DrawView ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *imageView2;
@property CGFloat lastRotation;
@property CGRect frame1;
@property CGRect frame2;

@end

@implementation XIU_DrawView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:frame];
        img.userInteractionEnabled = YES;
        img.image = [UIImage imageNamed:@"timg.jpeg"];
        [self addSubview:img];
        
        self.backgroundColor = [UIColor blackColor];
        
        CGFloat pointY = self.center.y;
        
        
        
        self.imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"longchar"]];
        self.imageView2.tag = 1;
        self.imageView2.frame  = CGRectMake(0, 0, 220, 220);
        self.imageView2.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [self.imageView2 setUserInteractionEnabled:YES];
        self.imageView2.layer.borderWidth = 3.f;
        self.imageView2.center = CGPointMake(self.center.x, pointY*2/3);
        
        [img addSubview:self.imageView2];
        self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"char"]];
        self.imageView.tag = 1;
        self.imageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.imageView.layer.borderWidth = 3.f;
        [self.imageView setUserInteractionEnabled:YES];
        self.imageView.frame  = CGRectMake(0, 0, 220, 220);
        self.imageView.center = CGPointMake(self.center.x, pointY*4/3);
        [img addSubview:self.imageView];
        self.multipleTouchEnabled = YES;
        
        
        
        
        
        
        
        
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.imageView addGestureRecognizer:tapGesture];
        
        UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2:)];
        [self.imageView2 addGestureRecognizer:tapGesture2];
        
        
        self.frame1 = self.imageView.frame;
        self.frame2 = self.imageView2.frame;

    }
    return self;
}


-(void)tap:(UITapGestureRecognizer *)sender {
    
    self.imageView2.layer.borderWidth = 0;
    
    self.imageView.layer.borderWidth = 3;
    
    UIRotationGestureRecognizer *rotationG = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationImage:)];
    rotationG.delegate = self;
    UIPinchGestureRecognizer *pinchGestureRecongnizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(changeImage:)];
    pinchGestureRecongnizer.delegate = self;
    [self.imageView addGestureRecognizer:pinchGestureRecongnizer];
    [self.imageView addGestureRecognizer:rotationG];
    
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panpan:)];
    [self.imageView addGestureRecognizer:panGesture];


}

-(void)tap2:(UITapGestureRecognizer *)sender {
    self.imageView.layer.borderWidth = 0;
    self.imageView2.layer.borderWidth = 3;
    
    UIRotationGestureRecognizer *rotationG2 = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationImage2:)];
    rotationG2.delegate = self;
    UIPinchGestureRecognizer *pinchGestureRecongnizer2 = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(changeImage2:)];
    pinchGestureRecongnizer2.delegate = self;
    [self.imageView2 addGestureRecognizer:pinchGestureRecongnizer2];
    [self.imageView2 addGestureRecognizer:rotationG2];
    

    UIPanGestureRecognizer *panGesture2=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panpan2:)];
    [self.imageView2 addGestureRecognizer:panGesture2];


}

- (void)panpan:(UIPanGestureRecognizer *)sender {
    [self bringSubviewToFront:self.imageView];

    self.imageView2.layer.borderWidth = 0;
    
    self.imageView.layer.borderWidth = 3;
    
    CGPoint location = [sender locationInView:self];
    sender.view.center = CGPointMake(location.x,  location.y);
    
    
}
- (void)panpan2:(UIPanGestureRecognizer *)sender {
    [self bringSubviewToFront:self.imageView2];
    
    self.imageView2.layer.borderWidth = 3;
    
    self.imageView.layer.borderWidth = 0;
    CGPoint location = [sender locationInView:self];
    sender.view.center = CGPointMake(location.x,  location.y);
}


- (void)rotationImage:(UIRotationGestureRecognizer*)gesture {
    [self bringSubviewToFront:gesture.view];
    

    CGPoint location = [gesture locationInView:self];
    gesture.view.center = CGPointMake(location.x, location.y);
    
    if ([gesture state] == UIGestureRecognizerStateEnded) {
        self.lastRotation = 0;
        return;
    }
    CGAffineTransform currentTransform = self.imageView.transform;
    CGFloat rotation = 0.0 - (self.lastRotation - gesture.rotation);
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, rotation);
    self.imageView.transform = newTransform;
    self.lastRotation = gesture.rotation;
}
- (void)changeImage:(UIPinchGestureRecognizer*)pinchGestureRecognizer {
    [self bringSubviewToFront:pinchGestureRecognizer.view];
    
    CGPoint location = [pinchGestureRecognizer locationInView:self];
    pinchGestureRecognizer.view.center = CGPointMake(location.x, location.y);
    pinchGestureRecognizer.view.transform = CGAffineTransformScale(pinchGestureRecognizer.view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    pinchGestureRecognizer.scale = 1;
    
    
    
}
- (void)changeImage2:(UIPinchGestureRecognizer*)pinchGestureRecognizer {
    
    [self bringSubviewToFront:pinchGestureRecognizer.view];
    CGPoint location = [pinchGestureRecognizer locationInView:self];
    pinchGestureRecognizer.view.center = CGPointMake(location.x, location.y);
    pinchGestureRecognizer.view.transform = CGAffineTransformScale(pinchGestureRecognizer.view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    pinchGestureRecognizer.scale = 1;
    
    
    
}
- (void)rotationImage2:(UIRotationGestureRecognizer*)gesture {
    
    
    
    
    [self bringSubviewToFront:gesture.view];
    CGPoint location = [gesture locationInView:self];
    gesture.view.center = CGPointMake(location.x, location.y);
    if ([gesture state] == UIGestureRecognizerStateEnded) {
        self.lastRotation = 0;
        return;
    }
    CGAffineTransform currentTransform = self.imageView2.transform;
    CGFloat rotation = 0.0 - (self.lastRotation - gesture.rotation);
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, rotation);
    self.imageView2.transform = newTransform;
    self.lastRotation = gesture.rotation;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return  YES;
}

@end
