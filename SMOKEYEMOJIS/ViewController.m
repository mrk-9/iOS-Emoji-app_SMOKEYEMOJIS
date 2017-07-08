//
//  ViewController.m
//  SMOKEYEMOJIS
//
//  Created by Hoang on 3/4/16.
//  Copyright © 2016 Hoang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic) UIImageView * imageView;
@property(nonatomic) NSInteger index;
@end

@implementation ViewController

- (id)initWithImage:(NSString *)image atIndex:(NSInteger)index  {
    if (self = [super init]) {
        self.image = image;
        self.index = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.imageView setImage:[UIImage imageNamed:self.image]];
    
    [self.view addSubview:self.imageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSString *)description {
    return @(self.index).stringValue;
}

- (void)setRatio:(CGFloat)ratio {
    CGFloat scale = 1.f - (0.05f - (ratio * 0.05f));
    self.imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
}

@end
