//
//  ViewController.h
//  SMOKEYEMOJIS
//
//  Created by Hoang on 3/4/16.
//  Copyright © 2016 Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic) NSString * image;

- (id)initWithImage:(NSString *)image atIndex:(NSInteger)index;

- (void)setRatio:(CGFloat)ratio;

@end

