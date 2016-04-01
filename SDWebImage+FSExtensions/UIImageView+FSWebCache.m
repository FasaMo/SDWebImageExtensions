//
//  UIImageView+FSWebCache.m
//  SDWebImageExtensions
//
//  Created by Fasa Mo on 16/3/31.
//  Copyright © 2016年 FasaMo. All rights reserved.
//

#import "UIImageView+FSWebCache.h"
#import "UIImageView+WebCache.h"
#import "UIView+WebCacheOperation.h"
#import <objc/runtime.h>

static char imageURLKey;

@implementation UIImageView (FSWebCache)

#pragma mark - Common Methods
- (void)fs_setImageWithURL:(NSString *)url
{
    [self fs_setImageWithURL:url placeholderImage:nil];
}

- (void)fs_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage
{
    [self fs_setImageWithURL:url placeholderImage:placeholderImage animateDuration:0 progress:nil completion:nil];
}

- (void)fs_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage completion:(FS_SDWebImageCompletionBlock)completionBlock
{
    [self fs_setImageWithURL:url placeholderImage:placeholderImage animateDuration:0 progress:nil completion:completionBlock];
}

- (void)fs_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage animateDuration:(NSTimeInterval)animateDuration progress:(FS_SDWebImageProgressBlock)progressBlock
{
    [self fs_setImageWithURL:url placeholderImage:placeholderImage animateDuration:animateDuration progress:progressBlock completion:nil];
}

- (void)fs_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage progress:(FS_SDWebImageProgressBlock)progressBlock completion:(FS_SDWebImageCompletionBlock)completionBlock
{
    [self fs_setImageWithURL:url placeholderImage:placeholderImage animateDuration:0 progress:progressBlock completion:completionBlock];
}

- (void)fs_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage animateDuration:(NSTimeInterval)animateDuration progress:(FS_SDWebImageProgressBlock)progressBlock completion:(FS_SDWebImageCompletionBlock)completionBlock
{
    __weak __typeof(self) wSelf = self;
    UIImage *placeholderRealImage = placeholderImage && placeholderImage.length ? [UIImage imageNamed:placeholderImage] : nil;
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderRealImage options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        !progressBlock ? : progressBlock(MAX(0, (CGFloat)receivedSize/(CGFloat)expectedSize));
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __strong __typeof(wSelf) sSelf = wSelf;
        if (!sSelf) return;
        if (!image) {
            !completionBlock ? : completionBlock(nil, error, imageURL);
            return;
        }
        if (![sSelf.sd_imageURL isEqual:imageURL]) {
            [sSelf fs_setImageWithURL:sSelf.sd_imageURL.absoluteString placeholderImage:placeholderImage animateDuration:animateDuration progress:progressBlock completion:completionBlock];
        } else {
            [sSelf fs_setImage:image url:imageURL duration:animateDuration completion:completionBlock];
        }
    }];
}

- (void)fs_setImage:(UIImage *)image url:(NSURL *)url duration:(NSTimeInterval)duration completion:(FS_SDWebImageCompletionBlock)completionBlock
{
    [UIView transitionWithView:self duration:duration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.image = image;
        [self setNeedsLayout];
    } completion:^(BOOL finished) {
        !completionBlock ? : completionBlock(image, nil, url);
    }];
}

#pragma mark - RoundImage
- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio
{
    [self fs_setRoundImageWithURL:urlString cornerRadiusRatio:cornerRadiusRatio placeholderImage:nil];
}

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio placeholderImage:(NSString *)placeholderImage
{
    [self fs_setRoundImageWithURL:urlString cornerRadiusRatio:cornerRadiusRatio placeholderImage:placeholderImage animateDuration:0 progress:nil completion:nil];
}

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio progressBlock:(FS_SDWebImageProgressBlock)progressBlock
{
    [self fs_setRoundImageWithURL:urlString cornerRadiusRatio:cornerRadiusRatio placeholderImage:nil animateDuration:0 progress:progressBlock completion:nil];
}

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio completion:(FS_SDWebImageCompletionBlock)completionBlock
{
    [self fs_setRoundImageWithURL:urlString cornerRadiusRatio:cornerRadiusRatio placeholderImage:nil animateDuration:0 progress:nil completion:completionBlock];
}

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio placeholderImage:(NSString *)placeholderImage completion:(FS_SDWebImageCompletionBlock)completionBlock
{
    [self fs_setRoundImageWithURL:urlString cornerRadiusRatio:cornerRadiusRatio placeholderImage:placeholderImage animateDuration:0 progress:nil completion:completionBlock];
}

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio placeholderImage:(NSString *)placeholderImage animateDuration:(NSTimeInterval)animateDuration
{
    [self fs_setRoundImageWithURL:urlString cornerRadiusRatio:cornerRadiusRatio placeholderImage:placeholderImage animateDuration:animateDuration progress:nil completion:nil];
}

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio placeholderImage:(NSString *)placeholderImage progress:(FS_SDWebImageProgressBlock)progressBlock completion:(FS_SDWebImageCompletionBlock)completionBlock
{
    [self fs_setRoundImageWithURL:urlString cornerRadiusRatio:cornerRadiusRatio placeholderImage:placeholderImage animateDuration:0 progress:progressBlock completion:completionBlock];
}

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio placeholderImage:(NSString *)placeholderImage animateDuration:(NSTimeInterval)animateDuration progress:(FS_SDWebImageProgressBlock)progressBlock completion:(FS_SDWebImageCompletionBlock)completionBlock
{
    // check urlString
    if (!urlString || !urlString.length) {
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:@"SDWebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            !completionBlock ? : completionBlock(nil, error, nil);
        });
        return;
    }
    NSURL *url = [NSURL URLWithString:urlString];
    
    // cancel previous operation
    [self sd_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // check placeholder
    UIImage *placeholderRealImage = placeholderImage && placeholderImage.length ? [UIImage imageNamed:placeholderImage] : nil;
    
    // if cached then use it
    UIImage *cachedImage = [SDWebImageManager.sharedManager.imageCache imageFromDiskCacheForKey:[SDWebImageManager.sharedManager cacheKeyForURL:url]];
    if (cachedImage) {
        [self fs_setImage:cachedImage url:url duration:animateDuration completion:completionBlock];
        return;
    }
    // no cached, set placeholder
    dispatch_main_async_safe(^{
        self.image = placeholderRealImage;
    });
    __weak __typeof(self) wSelf = self;
    id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager
                                          downloadImageWithURL:url
                                          options:SDWebImageRetryFailed
                                          progress:^(NSInteger receivedSize, NSInteger expectedSize) {
      !progressBlock ? : progressBlock(MAX(0, (CGFloat)receivedSize/(CGFloat)expectedSize));
                                          }
                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
      __strong __typeof(wSelf) sSelf = wSelf;
      if (!sSelf) return;
      
      dispatch_main_sync_safe(^{
          if (!image) {
              !completionBlock ? : completionBlock(nil, error, imageURL);
              return;
          }
          if (![objc_getAssociatedObject(self, &imageURLKey) isEqual:imageURL]) {
              [sSelf fs_setRoundImageWithURL:sSelf.sd_imageURL.absoluteString cornerRadiusRatio:cornerRadiusRatio placeholderImage:placeholderImage animateDuration:animateDuration progress:progressBlock completion:completionBlock];
              return;
          }
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              UIImage *roundImage = [image roundImageWithCornerRadius:image.size.width * (cornerRadiusRatio ? : .5f)];
              [SDWebImageManager.sharedManager.imageCache storeImage:roundImage forKey:[[SDWebImageManager sharedManager] cacheKeyForURL:imageURL]];
              dispatch_main_sync_safe(^{
                  [sSelf fs_setImage:roundImage url:imageURL duration:animateDuration completion:completionBlock];
              });
          });
      });
                                          }];
    [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
}

#pragma mark - Clear
+ (void)fs_clearMemory
{
    [[SDImageCache sharedImageCache] clearMemory];
    
    [[SDWebImageManager sharedManager] cancelAll];
}

+ (void)fs_clearDisk
{
    [[SDImageCache sharedImageCache] clearDisk];
}

@end

@implementation UIImage (RoundCorner)

- (UIImage *)roundImageWithCornerRadius:(CGFloat)radius
{
    CGRect rect = {.size = self.size};
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    [self drawInRect:rect];
    UIImage *roundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return roundImage;
}

@end;
