//
//  LVYViewController.m
//  LVYImageViewController-Demo
//
//  Created by Levey on 8/14/13.
//  Copyright (c) 2013 Levey. All rights reserved.
//

#import "LVYViewController.h"
#import "LVYImageViewController.h"
@interface LVYViewController ()

@end

@implementation LVYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}
- (IBAction)showImage {
    LVYImageViewController *ivc = [[LVYImageViewController alloc] initWithPlaceholderImage:[UIImage imageNamed:@"asuka.jpg"] imageUrl:@"http://photo2.bababian.com/upload5/20101105/9FBE2A149D137465EA950DF250EE3DB0.jpg"];
    
    [self addChildViewController:ivc];
    [self.view addSubview:ivc.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
