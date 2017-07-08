//
//  CustomUIScrollView.h
//  EF Emoticons
//
//  Created by Hoang on 6/14/15.
//  Copyright (c) 2015 Claan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
@protocol CustomUIScrollViewDelegate <NSObject>
- (void) iconPressedWithPage:(int)page index:(int) index name:(NSString*)btnLabel button:(UIButton*)button;
@end

@interface CustomUIScrollView : UIScrollView< DetailViewControllerDelegate>

- (void) setNumberOfPage:(int) numberOfPages contents:(NSDictionary*)contents;
- (void) relayoutAllContentsWithFrame:(CGRect)frame;
@property (weak, nonatomic) id <CustomUIScrollViewDelegate> customScrollViewDelegate;
@end
