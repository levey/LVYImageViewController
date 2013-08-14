//
//  LVYImageViewController.m
//  LVYImageViewController-Demo
//
//  Created by Levey on 8/14/13.
//  Copyright (c) 2013 Levey. All rights reserved.
//

#import "LVYImageViewController.h"
#import "SDWebImageManager.h"
@interface LVYImageViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) UIImage *downloadedImage;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation LVYImageViewController

#pragma mark - Initialization

- (id)initWithPlaceholderImage:(UIImage *)pimg imageUrl:(NSString *)urlString {
    if (self = [super init]) {
        self.placeholderImage = pimg;
        self.imageUrl = urlString;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.pagingEnabled = NO;
    self.scrollView.maximumZoomScale = 2.0f;
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.delegate = (id)self;
    
    [self.view addSubview:self.scrollView];
    
    self.imageView = [[UIImageView alloc] initWithImage:self.placeholderImage];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.frame = self.scrollView.bounds;
    [self.scrollView addSubview:self.imageView];
    
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    self.activityIndicatorView.center = self.view.center;
    [self.view addSubview:self.activityIndicatorView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tap.delaysTouchesEnded = YES;
    [self.scrollView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.scrollView addGestureRecognizer:doubleTap];
    
    [tap requireGestureRecognizerToFail:doubleTap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.scrollView addGestureRecognizer:longPress];

    
    __typeof(&*self) __unsafe_unretained uself = self;
    [self.activityIndicatorView startAnimating];
    [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:self.imageUrl] options:0 progress:^(NSUInteger receivedSize, long long expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
        if (image) {
            uself.downloadedImage = image;
            uself.imageView.image = image;
            [uself.activityIndicatorView stopAnimating];
        }
    }];
}

#pragma mark - UIScrollView delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


#pragma mark - Gestures

- (void)handleTapGesture:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self.view removeFromSuperview];

        if ([self respondsToSelector:@selector(removeFromParentViewController)]) {
            [self removeFromParentViewController];
        }
    }
}

- (void)handleDoubleTap:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if(self.scrollView.zoomScale == self.scrollView.minimumZoomScale){
            CGPoint point=[recognizer locationInView:self.scrollView];
            CGSize scrollViewSize = self.scrollView.bounds.size;
            
            CGFloat w=scrollViewSize.width/self.scrollView.maximumZoomScale;
            CGFloat h=scrollViewSize.height /self.scrollView.maximumZoomScale;
            CGFloat x= point.x-(w/2.0);
            CGFloat y = point.y-(h/2.0);
            
            CGRect rectTozoom=CGRectMake(x, y, w, h);
            [self.scrollView zoomToRect:rectTozoom animated:YES];
            
            [self.scrollView setZoomScale:2.0 animated:YES];
        }
        else{
            [self.scrollView setZoomScale:1.0 animated:YES];
        }
    }
}

- (void)handleLongPressGesture:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil delegate:(id)self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片到相册", nil];
        [as showInView:self.view];
    }
}


#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UIImageWriteToSavedPhotosAlbum(self.downloadedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}


#pragma mark - Image save delegate
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
}






@end
