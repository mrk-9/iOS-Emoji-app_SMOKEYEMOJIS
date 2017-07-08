//
//  CustomUIScrollView.m
//  EF Emoticons
//
//  Created by Hoang on 6/14/15.
//  Copyright (c) 2015 Claan. All rights reserved.
//

#import "CustomUIScrollView.h"
#import "DetailViewController.h"

@implementation CustomUIScrollView
{
    int _numberPages;
    NSDictionary *_contents;
    NSMutableArray *_details;
    DetailViewController *_detail;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) setNumberOfPage:(int) numberOfPages contents:(NSDictionary*)contents
{
    self.pagingEnabled = YES;
    _details = [NSMutableArray new];
    _numberPages = numberOfPages;
    _contents = contents;
    CGRect scrollViewRect = self.frame;
    for (int i = 0; i < numberOfPages; i++) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"KB" bundle:nil];
        _detail = [sb instantiateViewControllerWithIdentifier:@"DetailViewController"];
        NSArray *content = [contents objectForKey:[NSString stringWithFormat:@"SECTION%d", i]];
        _detail.icons = content;
        _detail.detailDelegate = self;
        _detail.view.frame = CGRectMake(i * CGRectGetWidth(scrollViewRect), 0, CGRectGetWidth(scrollViewRect), CGRectGetHeight(scrollViewRect));
        
        
        [_detail relayoutAllIcons:i];
        [self addSubview:_detail.view];
        [_details addObject:_detail];
    }
    self.contentSize = CGSizeMake(numberOfPages * CGRectGetWidth(self.frame), 0);
}

- (void) relayoutAllContentsWithFrame:(CGRect)frame
{
    self.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    self.contentSize = CGSizeMake(_numberPages * CGRectGetWidth(frame), 0);
    for (int i = 0; i<_details.count; i++) {
        DetailViewController *detail = _details[i];
        detail.view.frame = CGRectMake(i * CGRectGetWidth(frame), 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        [detail relayoutAllIcons:i];
    }
}

- (void)iconPressedWithPage:(int)page index:(int)index name:(NSString*)btnLabel button:(UIButton *)button
{
    if ([self.customScrollViewDelegate respondsToSelector:@selector(iconPressedWithPage:index: name: button:)]) {
        NSString *btnLabel = button.titleLabel.text;
        [self.customScrollViewDelegate iconPressedWithPage:page index:index name:btnLabel button:button];
        
    }
}
@end
