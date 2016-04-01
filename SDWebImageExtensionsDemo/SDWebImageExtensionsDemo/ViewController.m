//
//  ViewController.m
//  SDWebImageExtensionsDemo
//
//  Created by Fasa Mo on 16/3/31.
//  Copyright © 2016年 FasaMo. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+FSWebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)onLoadButton:(id)sender
{
    NSString *urlString = @"https://img3.doubanio.com/view/photo/photo/public/p1866358125.jpg";
    __weak __typeof(self) wSelf = self;
    [self.imageView fs_setRoundImageWithURL:urlString cornerRadiusRatio:.5f placeholderImage:nil progress:^(CGFloat progress) {
        __strong __typeof(wSelf) sSelf = wSelf;
        if (!sSelf) return;
        sSelf.progressLabel.text = [NSString stringWithFormat:@"%.1f",progress * 100];
    } completion:^(UIImage *image, NSError *error, NSURL *url) {
        __strong __typeof(wSelf) sSelf = wSelf;
        if (!sSelf) return;
        sSelf.progressLabel.text = @"100";
    }];
}

- (IBAction)onClearButton:(id)sender
{
    self.progressLabel.text = @"0";
    self.imageView.image = nil;
    [UIImageView fs_clearMemory];
    [UIImageView fs_clearDisk];
}

@end
