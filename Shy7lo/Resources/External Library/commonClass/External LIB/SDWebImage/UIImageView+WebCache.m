/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"
#import "objc/runtime.h"
#import "UIView+WebCacheOperation.h"
#import "Shy7lo-Swift.h"
#import "TSActivityIndicatorView.h"

static char imageURLKey;

@implementation UIImageView (WebCache)

- (void)sd_setImageWithURL:(NSURL *)url
{
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isCategory"]) {
        
        for (UIView *subview in self.subviews)
        {
            if([subview isKindOfClass:[UIActivityIndicatorView class]] || [subview isKindOfClass:[TSActivityIndicatorView class]])
            {
                [subview removeFromSuperview];
            }
        }

        CGFloat width = 150;
        CGFloat height = 199;
        
        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        if (appDel.isListVewAppear == true) {
            
            width = 300;
            height = 398;
        }
        
        
        TSActivityIndicatorView *customIndicator =
        [[TSActivityIndicatorView alloc]
         initWithFrame:CGRectMake(((width*[[UIScreen mainScreen] bounds].size.width)/320)/2-15,((height*[[UIScreen mainScreen] bounds].size.height)/568)/2-15, 30, 30)];
        
       /* TSActivityIndicatorView *customIndicator =
        [[TSActivityIndicatorView alloc]
         initWithFrame:CGRectMake(self.frame.size.width/2-15,self.frame.size.height/2-15, 30, 30)];*/
        
        /// Add frames as strings
        customIndicator.frames = @[@"activity-indicator-1",
                                   @"activity-indicator-2",
                                   @"activity-indicator-3",
                                   @"activity-indicator-4",
                                   @"activity-indicator-5",
                                   @"activity-indicator-6"];
        
        /// Add to subview
        [self addSubview:customIndicator];
        
        /// And start animate
        customIndicator.duration = 1.0f;
        [customIndicator startAnimating];
    }
    else
    {
        for (UIView *subview in self.subviews)
        {
            if([subview isKindOfClass:[UIActivityIndicatorView class]] || [subview isKindOfClass:[TSActivityIndicatorView class]])
            {
                [subview removeFromSuperview];
            }
        }

        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.frame=CGRectMake(self.frame.size.width/2-15,self.frame.size.height/2-15, 30, 30);
        
        [self addSubview:spinner];
        
        [spinner startAnimating];
    }
    
    
    
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isCategory"]) {
        
        for (UIView *subview in self.subviews)
        {
            if([subview isKindOfClass:[UIActivityIndicatorView class]] || [subview isKindOfClass:[TSActivityIndicatorView class]])
            {
                [subview removeFromSuperview];
            }
        }
        
        CGFloat width = 150;
        CGFloat height = 199;
        
        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        if (appDel.isListVewAppear == true) {
            
            width = 300;
            height = 398;
        }
        
        
        TSActivityIndicatorView *customIndicator =
        [[TSActivityIndicatorView alloc]
         initWithFrame:CGRectMake(((width*[[UIScreen mainScreen] bounds].size.width)/320)/2-15,((height*[[UIScreen mainScreen] bounds].size.height)/568)/2-15, 30, 30)];
        
        /* TSActivityIndicatorView *customIndicator =
         [[TSActivityIndicatorView alloc]
         initWithFrame:CGRectMake(self.frame.size.width/2-15,self.frame.size.height/2-15, 30, 30)];*/
        
        /// Add frames as strings
        customIndicator.frames = @[@"activity-indicator-1",
                                   @"activity-indicator-2",
                                   @"activity-indicator-3",
                                   @"activity-indicator-4",
                                   @"activity-indicator-5",
                                   @"activity-indicator-6"];
        
        /// Add to subview
        [self addSubview:customIndicator];
        
        /// And start animate
        customIndicator.duration = 1.0f;
        [customIndicator startAnimating];
    }
    else
    {
        for (UIView *subview in self.subviews)
        {
            if([subview isKindOfClass:[UIActivityIndicatorView class]] || [subview isKindOfClass:[TSActivityIndicatorView class]])
            {
                [subview removeFromSuperview];
            }
        }
        
        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.frame=CGRectMake(self.frame.size.width/2-15,self.frame.size.height/2-15, 30, 30);
        
        [self addSubview:spinner];
        
        [spinner startAnimating];
    }
    
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock
{
    NSLog(@"image tag == %d", self.tag);
    
    [self sd_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (!(options & SDWebImageDelayPlaceholder)) {
        self.image = placeholder;
    }
    
    if (url) {
        __weak UIImageView *wself = self;
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                if (!wself) return;
                if (image)
                {
                    for (UIView *subview in self.subviews)
                    {
                        if([subview isKindOfClass:[UIActivityIndicatorView class]] || [subview isKindOfClass:[TSActivityIndicatorView class]])
                        {
                            [subview removeFromSuperview];
                        }
                    }

                    if (self.tag == 1000) {
                        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    }
                    wself.image = image;
                    [wself setNeedsLayout];
                } else {
                    if ((options & SDWebImageDelayPlaceholder)) {
                        wself.image = placeholder;
                        [wself setNeedsLayout];
                    }
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
        [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
    } else {
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:@"SDWebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, SDImageCacheTypeNone, url);
            }
        });
    }
}

- (void)sd_setImageWithPreviousCachedImageWithURL:(NSURL *)url andPlaceholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock {
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    UIImage *lastPreviousCachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    
    [self sd_setImageWithURL:url placeholderImage:lastPreviousCachedImage ?: placeholder options:options progress:progressBlock completed:completedBlock];    
}

- (NSURL *)sd_imageURL {
    return objc_getAssociatedObject(self, &imageURLKey);
}

- (void)sd_setAnimationImagesWithURLs:(NSArray *)arrayOfURLs {
    [self sd_cancelCurrentAnimationImagesLoad];
    __weak UIImageView *wself = self;

    NSMutableArray *operationsArray = [[NSMutableArray alloc] init];

    for (NSURL *logoImageURL in arrayOfURLs) {
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:logoImageURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                __strong UIImageView *sself = wself;
                [sself stopAnimating];
                if (sself && image) {
                    NSMutableArray *currentImages = [[sself animationImages] mutableCopy];
                    if (!currentImages) {
                        currentImages = [[NSMutableArray alloc] init];
                    }
                    [currentImages addObject:image];

                    sself.animationImages = currentImages;
                    [sself setNeedsLayout];
                }
                [sself startAnimating];
            });
        }];
        [operationsArray addObject:operation];
    }

    [self sd_setImageLoadOperation:[NSArray arrayWithArray:operationsArray] forKey:@"UIImageViewAnimationImages"];
}

- (void)sd_cancelCurrentImageLoad {
    [self sd_cancelImageLoadOperationWithKey:@"UIImageViewImageLoad"];
}

- (void)sd_cancelCurrentAnimationImagesLoad {
    [self sd_cancelImageLoadOperationWithKey:@"UIImageViewAnimationImages"];
}

@end


@implementation UIImageView (WebCacheDeprecated)

- (NSURL *)imageURL {
    return [self sd_imageURL];
}

- (void)setImageWithURL:(NSURL *)url {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
    }];
}

- (void)cancelCurrentArrayLoad {
    [self sd_cancelCurrentAnimationImagesLoad];
}

- (void)cancelCurrentImageLoad {
    [self sd_cancelCurrentImageLoad];
}

- (void)setAnimationImagesWithURLs:(NSArray *)arrayOfURLs {
    [self sd_setAnimationImagesWithURLs:arrayOfURLs];
}

@end
