//
//  DetailViewController.h
//  EF Emoticons
//
//  Created by Hoang on 6/14/15.
//  Copyright (c) 2015 Claan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailViewControllerDelegate <NSObject>
- (void) iconPressedWithPage:(int)page index:(int) index name:(NSString*)btnLabel button:(UIButton*)button;
@end

@interface DetailViewController : UIViewController
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSArray *icons;
- (void) relayoutAllIcons:(int)page_index;
@property (weak, nonatomic) id <DetailViewControllerDelegate> detailDelegate;
@end
