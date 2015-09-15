//
//  KGWelcomePageViewController.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/15.
//  Copyright (c) 2015年 gy. All rights reserved.
//

#import "KGWelcomePageViewController.h"
#import "KGHomePageViewController.h"
#define kStartButtonCenterYRatio 470.f/667.f
#define kPageControlCenterYRatio 637.f/667.f
@interface KGWelcomePageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrowView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation KGWelcomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //SCROWVIEW 填充屏幕，让pageControl处于屏幕637/667
    _scrowView.frame=[UIScreen mainScreen].bounds;
    _pageControl.center=CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*kPageControlCenterYRatio);
    
    //设置scrowView包括显示图片以及contentSize等
    [self setUpScrowView];
    //设置pageControl的点数
    _pageControl.numberOfPages = 5;
}
#pragma mark 设置scrowView包括显示图片以及contentSize等
-(void)setUpScrowView
{
    for (int i=0; i<5; i++)
    {
        UIImageView*imageView=[[UIImageView alloc]init];
        NSString*imageName=[NSString stringWithFormat:@"introduction_%d",i+1];
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.frame=CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        if (i==4) {
            //添加 开启音乐之旅按钮,封装函数,通过传参数，来给第五个添加这个控件,参数:imageView
            
            [self addStartButton:imageView];

        }
        
        
        
        [_scrowView addSubview:imageView];
        
    }
    _scrowView.contentSize=CGSizeMake(5*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _scrowView.pagingEnabled=YES;
    _scrowView.bounces=NO;

}
//第五个
-(void)addStartButton:(UIImageView*)imageView
{
    //可以点击
    imageView.userInteractionEnabled=YES;
    
    
    UIButton*startButton=[[UIButton alloc]init];
    startButton.bounds=CGRectMake(0, 0, 122, 32);
    startButton.center=CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*kStartButtonCenterYRatio);
    
    //startButton.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/5 , [UIScreen mainScreen].bounds.size.height*0.8, 244.f, 54.f);
   
    [startButton setBackgroundImage:[UIImage imageNamed:@"introduction_enter_nomal"] forState:UIControlStateNormal];
      [startButton setBackgroundImage:[UIImage imageNamed:@"introduction_enter_press"] forState:UIControlStateHighlighted];
    [startButton addTarget:self action:@selector(startMusicChip:) forControlEvents:UIControlEventTouchUpInside];
    //把参数传到imageView上
    [imageView addSubview:startButton];
}
#pragma mark 开启音乐之旅
-(void)startMusicChip:(UIButton*)sender
{
//直接将主页设置为window的rootviewController，这样就不会回到到欢迎页,无返回,纯代码
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KGHomePageViewController*homeVc=[storyboard instantiateViewControllerWithIdentifier:@"homePage"];
    [UIApplication sharedApplication].keyWindow.rootViewController=homeVc;
    
}
//通过距离，偏移量，找到点数
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger number=(NSUInteger)_scrowView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    _pageControl.currentPage=number;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
