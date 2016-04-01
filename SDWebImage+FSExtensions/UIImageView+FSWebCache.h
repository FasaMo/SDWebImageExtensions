//
//  UIImageView+FSWebCache.h
//  SDWebImageExtensions
//
//  Created by Fasa Mo on 16/3/31.
//  Copyright © 2016年 FasaMo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FS_SDWebImageCompletionBlock)(UIImage *image, NSError *error, NSURL *url);
typedef void (^FS_SDWebImageProgressBlock)(CGFloat progress);

@interface UIImageView (FSWebCache)
#pragma mark - Common Methods
- (void)fs_setImageWithURL:(NSString *)url;

- (void)fs_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage;

- (void)fs_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage completion:(FS_SDWebImageCompletionBlock)completionBlock;

- (void)fs_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage animateDuration:(NSTimeInterval)animateDuration progress:(FS_SDWebImageProgressBlock)progressBlock;

- (void)fs_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage progress:(FS_SDWebImageProgressBlock)progressBlock completion:(FS_SDWebImageCompletionBlock)completionBlock;

- (void)fs_setImageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage animateDuration:(NSTimeInterval)animateDuration progress:(FS_SDWebImageProgressBlock)progressBlock completion:(FS_SDWebImageCompletionBlock)completionBlock;

#pragma mark - RoundImage
- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio;

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio placeholderImage:(NSString *)placeholderImage;

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio progressBlock:(FS_SDWebImageProgressBlock)progressBlock;

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio completion:(FS_SDWebImageCompletionBlock)completionBlock;

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio placeholderImage:(NSString *)placeholderImage completion:(FS_SDWebImageCompletionBlock)completionBlock;

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio placeholderImage:(NSString *)placeholderImage animateDuration:(NSTimeInterval)animateDuration;

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio placeholderImage:(NSString *)placeholderImage progress:(FS_SDWebImageProgressBlock)progressBlock completion:(FS_SDWebImageCompletionBlock)completionBlock;

- (void)fs_setRoundImageWithURL:(NSString *)urlString cornerRadiusRatio:(CGFloat)cornerRadiusRatio placeholderImage:(NSString *)placeholderImage animateDuration:(NSTimeInterval)animateDuration progress:(FS_SDWebImageProgressBlock)progressBlock completion:(FS_SDWebImageCompletionBlock)completionBlock;

#pragma mark - Clear
+ (void)fs_clearMemory;

+ (void)fs_clearDisk;

@end

@interface UIImage (FS_RoundCorner)
- (UIImage *)roundImageWithCornerRadius:(CGFloat)radius;
@end
