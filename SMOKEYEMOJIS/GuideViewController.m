//
//  GuideViewController.m
//  SMOKEYEMOJIS
//
//  Created by Fedoro on 3/18/16.
//  Copyright © 2016 Hoang. All rights reserved.
//

#import "GuideViewController.h"
#import "MNPageViewController.h"
#import "ViewController.h"

@interface GuideViewController ()<MNPageViewControllerDataSource, MNPageViewControllerDelegate>
@property(nonatomic,strong) NSArray *images;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.images = @[@"guide2.jpg", @"guide3.jpg", @"guide4.jpg", @"guide5.jpg", @"guide6.jpg", @"guide7.jpg", @"pimgpsh_fullsize_distr.png"];
    
    [self.navigationBar setHidden:YES];
    MNPageViewController *controller = [[MNPageViewController alloc] init];
    controller.viewController = [[ViewController alloc] initWithImage:self.images[0] atIndex:0];
    controller.dataSource = self;
    controller.delegate = self;
    [self setViewControllers:[NSArray arrayWithObjects:controller, nil] animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MNPageViewControllerDataSource

- (UIViewController *)mn_pageViewController:(MNPageViewController *)pageViewController viewControllerBeforeViewController:(ViewController *)viewController {
    NSUInteger index = [self.images indexOfObject:viewController.image];
    if (index == NSNotFound || index == 0) {
        return nil;
    }
    return [[ViewController alloc] initWithImage:self.images[index - 1] atIndex:-1];
}

- (UIViewController *)mn_pageViewController:(MNPageViewController *)pageViewController viewControllerAfterViewController:(ViewController *)viewController {
    NSUInteger index = [self.images indexOfObject:viewController.image];
    
    if (index == (self.images.count-1)) {
        [self dismissViewControllerAnimated:NO completion:nil];
        return nil;
    }
    
    if (index == NSNotFound || index == (self.images.count - 1)) {
        return nil;
    }
    return [[ViewController alloc] initWithImage:self.images[index + 1] atIndex:index + 1];
}

#pragma mark - MNPageViewControllerDelegate

- (void)mn_pageViewController:(MNPageViewController *)pageViewController didScrollViewController:(ViewController *)viewController withRatio:(CGFloat)ratio {
    [viewController setRatio:ratio];
}

@end