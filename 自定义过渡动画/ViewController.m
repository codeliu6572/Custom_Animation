//
//  ViewController.m
//  自定义过渡动画
//
//  Created by 刘浩浩 on 16/6/28.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *imageView;
    NSArray *images;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor orangeColor];
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(80, 80, 150, 150)];
    [self.view addSubview:imageView];
    images = @[[UIImage imageNamed:@"1"],
               [UIImage imageNamed:@"2"],
               [UIImage imageNamed:@"3"],
               [UIImage imageNamed:@"4"]];

    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame = CGRectMake(20, 568-100, 280, 40);
    [btn1 setTitle:@"Switch  自定义动画" forState:UIControlStateNormal];
    btn1.layer.cornerRadius=5;
    btn1.layer.borderWidth=1;
    btn1.layer.borderColor = [UIColor blackColor].CGColor;
    [btn1 addTarget:self action:@selector(switchImage1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];

    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(20, 568-50, 280, 40);
    [btn2 setTitle:@"Switch UIView特性" forState:UIControlStateNormal];
    btn2.layer.cornerRadius=5;
    btn2.layer.borderWidth=1;
    btn2.layer.borderColor = [UIColor blackColor].CGColor;
    [btn2 addTarget:self action:@selector(switchImage2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
}
- (void)switchImage1
{
    
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, YES, 0.0);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    //insert snapshot view in front of this one
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = CGRectMake(80, 80, 150, 150);
    [self.view addSubview:coverView];
    //update the view (we'll simply randomize the layer background color)
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0]; //perform animation (anything you like)
    [UIView animateWithDuration:1.0 animations:^{
        //scale, rotate and fade the view
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0.0;
        UIImage *currentImage = imageView.image;
        NSUInteger index = [images indexOfObject:currentImage];
        index = (index + 1) % [images count];
        imageView.image = images[index];
        
    } completion:^(BOOL finished) {
        //remove the cover view now we're finished with it
        [coverView removeFromSuperview];

    }];
    
}

-(void)switchImage2
{
    [UIView transitionWithView:imageView duration:1.0
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                        //cycle to next image
                        UIImage *currentImage = imageView.image;
                        NSUInteger index = [images indexOfObject:currentImage];
                        index = (index + 1) % [images count];
                        imageView.image = images[index];
                    }
                    completion:NULL];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
