//
//  ViewController.m
//  FrostedGlass
//
//  Created by issuser on 16/5/9.
//  Copyright © 2016年 issuser. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    UIImage * tempImage = [UIImage imageNamed:@"page1"];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIImage * img = [self setImage:tempImage];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.image = img;
    [self.view addSubview:imageView];
 
    //[self createImageOption];

}

//系统方法，iOS8以上
//方法一：系统方法，iOS8及以上可用
- (void)createImageOption{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage * tempImage = [UIImage imageNamed:@"page1"];
    [self.view addSubview:imageView];
    imageView.image = tempImage;
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        blurEffectView.frame = imageView.bounds;
        [imageView addSubview:blurEffectView];
    }
}

#pragma mark--毛玻璃效果方法2
- (UIImage *)setImage:(UIImage *)theImage{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0]forKey:@"inputRadius"];//其中数值是模糊度（3～30，越大越模糊）
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return returnImage;
}



@end
