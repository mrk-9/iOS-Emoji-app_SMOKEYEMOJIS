//
//  DetailViewController.m
//  EF Emoticons
//
//  Created by Hoang on 6/14/15.
//  Copyright (c) 2015 Claan. All rights reserved.
//

#import "DetailViewController.h"

#define ICON_SIZE 30.0f
#define NUMBER_OF_ITEMS_PER_PAGE_WIDTH_SCREEN 8
#define NUMBER_OF_ITEMS_PER_PAGE_HEIGHT_SCREEN 3


@interface DetailViewController ()

@end

@implementation DetailViewController
{
    NSMutableArray *_tempButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tempButtons = [NSMutableArray new];
    
    for (int i = 0 ; i < _icons.count; i++) {
        @autoreleasepool {
            UIButton *btn = [self createIconButton];
            [_tempButtons addObject:btn];
            [[btn imageView] setContentMode: UIViewContentModeScaleAspectFit];
            [btn setImage:[UIImage imageNamed:_icons[i]] forState:UIControlStateNormal];
            [self.view addSubview:btn];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) relayoutAllIcons:(int)page_index
{
    if (!_tempButtons || _tempButtons.count == 0) {
        return;
    }
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    int iconSize = ICON_SIZE;
    int heightSize = NUMBER_OF_ITEMS_PER_PAGE_HEIGHT_SCREEN;
    int widthSize = NUMBER_OF_ITEMS_PER_PAGE_WIDTH_SCREEN;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        iconSize = ICON_SIZE + 10.f;
    }
    
//    if([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height){
//        heightSize = 3;
//        widthSize = 6;
//    }
//    else{
//        heightSize = 2;
//        widthSize = 9;
//    }
    
    NSString * page_title = @"";
    
    switch (page_index) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
            page_title = @"SMILES";
            break;
        case 7:
            page_title = @"EXPRESSIONS\nAND TEXT";
            break;
        case 8:
        case 9:
            page_title = @"TOOLS";
            break;
        case 10:
        case 11:
            page_title = @"OBJECTS";
            break;
        case 12:
            page_title = @"SYMBOLS";
            break;
        case 13:
            page_title = @"Flags";
            break;
        default:
            break;
    }
    
    UITextView * pageTitle = [[UITextView alloc] initWithFrame:CGRectMake((width - (iconSize * widthSize))/ (widthSize + 1), 0, 200, 40)];
    [pageTitle setText:page_title];
    [pageTitle setTextColor:[UIColor grayColor]];
    [self.view addSubview:pageTitle];
    
    UIView * btn_view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, width, height-30)];
    
    float remaingSpaceWidth = (width - (iconSize * widthSize))/ (widthSize + 1);
    float remaingSpaceHeight = (height - (iconSize * heightSize))/ (heightSize + 1);
    for (int i = 0; i < _icons.count; i++)
    {
        int row = (i / widthSize );
        
        UIButton *btn = _tempButtons[i];
        btn.tag = i;
        
        btn.titleLabel.text = _icons[i];
        btn.adjustsImageWhenHighlighted = NO;
        
        btn.frame = CGRectMake((remaingSpaceWidth * ((i % widthSize) + 1)) + (iconSize * ( i % widthSize)),
                               remaingSpaceHeight * (row + 1) + (iconSize * row),
                               iconSize,
                               iconSize);
        [btn_view addSubview:btn];
        
    }
    
    [self.view addSubview:btn_view];
}

- (UIButton*) createIconButton
{
    UIButton *btn;
    btn = [[UIButton alloc] init];
    [btn setTitle:@"" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(iconButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void) iconButtonPressed:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    if ([self.detailDelegate respondsToSelector:@selector(iconPressedWithPage:index:name:button:)]) {
        [self.detailDelegate iconPressedWithPage:self.page index:(int)btn.tag name:_icons[btn.tag] button:btn];
    }
}

@end
