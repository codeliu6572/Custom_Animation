# Custom_Animation
自定义过渡动画
![image](https://github.com/codeliu6572/Custom_Animation/blob/master/自定义过渡动画/1.gif)

Core Aniamtion中提供的变换类型并不能满足我们对动画的需要，所以我们会用到基础动画的组合，详情请访问博主博客http://blog.csdn.net/CodingFire查看Core Animation部分
的动画，这里来说说另一种做动画的方法。

很奇怪苹果在UIView中提供了动画的过渡方法：

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
options可设置的变量还有：

    UIViewAnimationOptionTransitionNone           = 0 << 20, // default
    UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
    UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
    UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
    UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
    UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
    UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
    UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
    
除了利用UIView特性提供的过渡变换外，我们还可以利用transform提供的缩放，旋转和平移方法，再借助UIView的特性来实现动画
实现方法如下：

    //截图 UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, YES, 0.0);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    //拿到截图的图片，放置在原图位置坐操作
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = CGRectMake(80, 80, 150, 150);
    [self.view addSubview:coverView];
    //update the view color(we'll simply randomize the layer background color)
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
        
此处的原理是在原图上截图，并添加到原图上进行覆盖，然后对覆盖原图的截图进行缩放旋转透明度变化的操作，这里还有其他的组合方式，只要美观，
可任意组合。








