//
//  KeyboardViewController.m
//


#import "KeyboardViewController.h"
#import "CustomUIScrollView.h"
#import "ConstantDefinition.h"

#define EMOJI_SIZE 35.0f
#define PAGE_SECTION1 5
#define PAGE_SECTION2 3
#define PAGE_SECTION3 2
#define PAGE_SECTION4 1
#define PAGE_SECTION5 1


@interface KeyboardViewController ()<UIScrollViewDelegate, CustomUIScrollViewDelegate>
{
    
    int _shiftStatus; //0 = off, 1 = on, 2 = caps lock
    CustomUIScrollView *_scrollView;
    CustomUIScrollView *_scrollViewSection1;
    CustomUIScrollView *_scrollViewSection2;
    CustomUIScrollView *_scrollViewSection3;
    CustomUIScrollView *_scrollViewSection4;
    CustomUIScrollView *_scrollViewSection5;
    
    NSMutableArray *content1;
    NSMutableArray *content2;
    NSMutableArray *content3;
    NSMutableArray *content4;
    NSMutableArray *content5;
    NSMutableArray *content6;
    NSMutableArray *content7;
    NSMutableArray *content8;
    NSMutableArray *content9;
    NSMutableArray *content10;
    NSMutableArray *content11;
    NSMutableArray *content12;
    NSMutableArray *content13;
    NSMutableArray *content14;
    
}

@property (weak, nonatomic) IBOutlet UIView *helpView;

@property (weak, nonatomic) IBOutlet UIView *emojiView;

// emoji view
@property (weak, nonatomic) IBOutlet UIView *row4EmojiView;
@property (weak, nonatomic) IBOutlet UIButton *section1;
@property (weak, nonatomic) IBOutlet UIButton *section2;
@property (weak, nonatomic) IBOutlet UIButton *section3;
@property (weak, nonatomic) IBOutlet UIButton *section4;
@property (weak, nonatomic) IBOutlet UIButton *section5;
@property (weak, nonatomic) IBOutlet UIButton *section6;

@property (weak, nonatomic) IBOutlet UIButton *globalEmojiButton;
@property (weak, nonatomic) IBOutlet UIButton *abcEmojiButton;
@property (weak, nonatomic) IBOutlet UIButton *section1EmojiButton;
@property (weak, nonatomic) IBOutlet UIButton *backSpaceEmojiButton;

@property (weak, nonatomic) IBOutlet UILabel *emojiCopiedLabel;
@property (weak, nonatomic) IBOutlet UILabel *emojiAllowAccessLabel;
@property (weak, nonatomic) IBOutlet UILabel *emojiAllowMsgLabel;
@property (weak, nonatomic) IBOutlet UILabel *emojiAllowMsgLabel2;

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSDate *dateFinal;

@property (strong, nonatomic) AlphabeticViewController *alphabeticController;


@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createEmojisFirstLoading];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - TextInput methods

- (void)textWillChange:(id<UITextInput>)textInput {
    
}

- (void)textDidChange:(id<UITextInput>)textInput {
    
}

#pragma mark - Actions

- (void) helpViewFadeInOut {
    
    [_helpView setAlpha:0.f];
    _helpView.hidden = NO;
    
    [UIView animateWithDuration:2.f delay:0.f options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
        animations:^{
        [_helpView setAlpha:0.95f];
    } completion:^(BOOL finished) {
        if (!finished)
            return;
        
        [UIView animateWithDuration:4.f delay:0.f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            [_helpView setAlpha:0.f];
        } completion:^(BOOL finished){
            if(!finished)
                return;
            self.helpView.hidden = YES;
        }];
    }];

}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer{
    if (_helpView.hidden == NO) {
        [self performSelectorOnMainThread:@selector(stopAnimation) withObject:nil waitUntilDone:YES];
    }

}

-(void)stopAnimation {
    [self.helpView.layer removeAllAnimations];
    _helpView.hidden = YES;
    
}


//External Test function called from another view
-(void) testExternalFunction {
    [self.textDocumentProxy insertText:@"A"];
    [self advanceToNextInputMode];
    NSLog(@"Called external function!");
}



#pragma mark - key methods

- (IBAction) globeKeyPressed:(id)sender {
    
    //required functionality, switches to user's next keyboard
    [self advanceToNextInputMode];
}

- (IBAction)returnKeyPressed:(id)sender {
    self.alphabeticController.rootController = self;
    
    //NORMAL PRESENTATION
    [self presentViewController:self.alphabeticController animated:NO completion:nil];
//    [self advanceToNextInputMode];
}

-(IBAction) backspaceKeyPressed: (UIButton*) sender {
    
    [self.textDocumentProxy deleteBackward];
}

#pragma mark - Emoji

- (void) createEmojisFirstLoading
{
    NSDictionary *dic;
    content1 = [[NSMutableArray alloc] init];
    content2 = [[NSMutableArray alloc] init];
    content3 = [[NSMutableArray alloc] init];
    content4 = [[NSMutableArray alloc] init];
    content5 = [[NSMutableArray alloc] init];
    content6 = [[NSMutableArray alloc] init];
    content7 = [[NSMutableArray alloc] init];
    content8 = [[NSMutableArray alloc] init];
    content9 = [[NSMutableArray alloc] init];
    content10 = [[NSMutableArray alloc] init];
    content11 = [[NSMutableArray alloc] init];
    content12 = [[NSMutableArray alloc] init];
    content13 = [[NSMutableArray alloc] init];
    content14 = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 244; i ++) {
        
        NSString * emojiName = [NSString stringWithFormat:@"emoji%d.png", i];
        if (i == 243) {
            [content12 addObject:emojiName];
        } else if (i > 0 && i < 25) {
            
            // section 1;
            
            [content1 addObject:emojiName];
        }   else if(i > 24 && i < 49)   {
            
            // section 1;
            
            [content2 addObject:emojiName];
        } else if(i > 48 && i < 61) {
            
            // section 1;
            
            [content3 addObject:emojiName];
        } else if (i > 60 && i < 85)    {
            
            // section 1;
            
            [content4 addObject:emojiName];
        } else if (i > 84 && i < 109)   {
            // section 1;
            
            [content5 addObject:emojiName];
        } else if (i > 108 && i < 133)  {
            
            // section 1;
            
            [content6 addObject:emojiName];
        } else if(i > 132 && i < 152)   {
            
            // section 1;
            
            [content7 addObject:emojiName];
        } else if(i > 151 && i < 167)   {
            
            // section 2;
            
            [content8 addObject:emojiName];
        } else if (i > 166 && i < 191)  {
            
            // section 3;
            
            [content9 addObject:emojiName];
        } else if(i > 190 && i < 205)   {
            
            // section 3;
            
            [content10 addObject:emojiName];
        } else if(i > 204 && i < 229)   {
            
            // section 4;
            
            [content11 addObject:emojiName];
        } else if (i > 228 && i < 231)  {
            
            // section 4;
            
            [content12 addObject:emojiName];
        } else if (i > 230 && i < 241)  {
            
            // section 5;
            
            [content13 addObject:emojiName];
        } else if (i > 240 && i < 243)  {
            // section 6;
            [content14 addObject:emojiName];
        }
    }

    dic = [NSDictionary dictionaryWithObjectsAndKeys:
           [NSArray arrayWithArray:content1],SECTION0,
           [NSArray arrayWithArray:content2],SECTION1,
           [NSArray arrayWithArray:content3],SECTION2,
           [NSArray arrayWithArray:content4],SECTION3,
           [NSArray arrayWithArray:content5],SECTION4,
           [NSArray arrayWithArray:content6],SECTION5,
           [NSArray arrayWithArray:content7],SECTION6,
           [NSArray arrayWithArray:content8],SECTION7,
           [NSArray arrayWithArray:content9],SECTION8,
           [NSArray arrayWithArray:content10],SECTION9,
           [NSArray arrayWithArray:content11],SECTION10,
           [NSArray arrayWithArray:content12],SECTION11,
           [NSArray arrayWithArray:content13],SECTION12,
           [NSArray arrayWithArray:content14],SECTION13,
           nil];
    
    
    _scrollViewSection1 = [[CustomUIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame))];
    _scrollViewSection1.delegate = self;
    _scrollViewSection1.customScrollViewDelegate = self;
    [self.contentView addSubview:_scrollViewSection1];
    [_scrollViewSection1 setNumberOfPage:14 contents:dic];
    
    self.pageControl.numberOfPages = 14;
    
    [self.contentView bringSubviewToFront:_scrollViewSection1];
    [self.section1 setSelected:YES];
    
    _scrollViewSection1.bounces = NO;

    [_scrollViewSection1 setShowsHorizontalScrollIndicator:NO];

}

- (void)iconPressedWithPage:(int)page index:(int)index name:(NSString *)btnLabel button:(UIButton *)button
{
    
    if ([[UIPasteboard generalPasteboard] isKindOfClass:[UIPasteboard class]] == YES) {
        
        self.emojiCopiedLabel.hidden = NO;
        self.emojiAllowMsgLabel.hidden = YES;
        self.emojiAllowAccessLabel.hidden = YES;
        self.emojiAllowMsgLabel2.hidden = YES;
        
        NSLog(@"--- %@  ---",btnLabel);
        
        NSString * filePath = [[NSBundle mainBundle] pathForResource:btnLabel ofType:@""];
        
        NSData* imgData = [NSData dataWithContentsOfFile:filePath];
        UIPasteboard *pasteBoard=[UIPasteboard generalPasteboard];
        [pasteBoard setData:imgData forPasteboardType:[UIPasteboardTypeListImage objectAtIndex:0]];
        
    }
    else {
        self.emojiCopiedLabel.hidden = YES;
        self.emojiAllowMsgLabel.hidden = NO;
        self.emojiAllowAccessLabel.hidden = NO;
        self.emojiAllowMsgLabel2.hidden = NO;
    }
    
    [self helpViewFadeInOut];

}

- (BOOL)isContainSmile:(NSString *)emoji forArray:(NSMutableArray *)emojis  {
    
    BOOL isContain = NO;
    
    for (int i = 0; i < emojis.count; i ++) {
        if ([[emojis objectAtIndex:i] isEqualToString:emoji]) {
            isContain = true;
            break;
        }
    }
    
    return isContain;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    self.pageControl.currentPage = scrollView.contentOffset.x / pageWidth;
    
    if (self.pageControl.currentPage >= 0 && self.pageControl.currentPage < 7) {
        [_section1 setSelected:YES];
        [_section2 setSelected:NO];
        [_section3 setSelected:NO];
        [_section4 setSelected:NO];
        [_section5 setSelected:NO];
        [_section6 setSelected:NO];
    } else if(self.pageControl.currentPage == 7)    {
        [_section1 setSelected:NO];
        [_section2 setSelected:YES];
        [_section3 setSelected:NO];
        [_section4 setSelected:NO];
        [_section5 setSelected:NO];
        [_section6 setSelected:NO];
    } else if(self.pageControl.currentPage >= 8 && self.pageControl.currentPage < 10)    {
        [_section1 setSelected:NO];
        [_section2 setSelected:NO];
        [_section3 setSelected:YES];
        [_section4 setSelected:NO];
        [_section5 setSelected:NO];
        [_section6 setSelected:NO];
    } else if(self.pageControl.currentPage >= 10 && self.pageControl.currentPage < 12)    {
        [_section1 setSelected:NO];
        [_section2 setSelected:NO];
        [_section3 setSelected:NO];
        [_section4 setSelected:YES];
        [_section5 setSelected:NO];
        [_section6 setSelected:NO];
    } else if (self.pageControl.currentPage == 12) {
        [_section1 setSelected:NO];
        [_section2 setSelected:NO];
        [_section3 setSelected:NO];
        [_section4 setSelected:NO];
        [_section5 setSelected:YES];
        [_section6 setSelected:NO];
    }else if(self.pageControl.currentPage == 13)    {
        [_section1 setSelected:NO];
        [_section2 setSelected:NO];
        [_section3 setSelected:NO];
        [_section4 setSelected:NO];
        [_section5 setSelected:NO];
        [_section6 setSelected:YES];
    }
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.emojiView.frame), CGRectGetHeight(self.emojiView.frame));

    [_scrollViewSection1 relayoutAllContentsWithFrame:self.contentView.frame];
    [_scrollViewSection2 relayoutAllContentsWithFrame:self.contentView.frame];
    [_scrollViewSection3 relayoutAllContentsWithFrame:self.contentView.frame];
    [_scrollViewSection4 relayoutAllContentsWithFrame:self.contentView.frame];
    [_scrollViewSection5 relayoutAllContentsWithFrame:self.contentView.frame];

    //relayout scroll view to prevent wrong layout
    _scrollView.contentOffset = CGPointMake(self.pageControl.currentPage * CGRectGetWidth(self.view.frame), 0);
 
    if([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height){
        self.globalEmojiButton.imageView.contentMode = UIViewContentModeCenter;
        self.abcEmojiButton.imageView.contentMode = UIViewContentModeCenter;
        self.section1EmojiButton.imageView.contentMode = UIViewContentModeCenter;
        self.backSpaceEmojiButton.imageView.contentMode = UIViewContentModeCenter;
    

    }
}

#pragma mark - IBAction for row 4 emoji view

- (IBAction)section1Clicked:(id)sender {
    
    [_section1 setSelected:YES];
    [_section2 setSelected:NO];
    [_section3 setSelected:NO];
    [_section4 setSelected:NO];
    [_section5 setSelected:NO];
    [_section6 setSelected:NO];

    _scrollViewSection1.contentOffset = CGPointMake(_scrollViewSection1.frame.size.width*0, 0);
    
    self.pageControl.currentPage = 0;
//    self.pageControl.numberOfPages = PAGE_SECTION1;
    [self.contentView bringSubviewToFront:_scrollViewSection1];
}
- (IBAction)section2Clicked:(id)sender {
    
    [_section1 setSelected:NO];
    [_section2 setSelected:YES];
    [_section3 setSelected:NO];
    [_section4 setSelected:NO];
    [_section5 setSelected:NO];
    [_section6 setSelected:NO];
    
    _scrollViewSection1.contentOffset = CGPointMake(_scrollViewSection1.frame.size.width*7, 0);
    
    self.pageControl.currentPage = 7;
//    self.pageControl.numberOfPages = PAGE_SECTION4;
    [self.contentView bringSubviewToFront:_scrollViewSection1];
}
- (IBAction)section3Clicked:(id)sender {
    
    [_section1 setSelected:NO];
    [_section2 setSelected:NO];
    [_section3 setSelected:YES];
    [_section4 setSelected:NO];
    [_section5 setSelected:NO];
    [_section6 setSelected:NO];
    
    _scrollViewSection1.contentOffset = CGPointMake(_scrollViewSection1.frame.size.width*8, 0);
    
    self.pageControl.currentPage = 8;
//    self.pageControl.numberOfPages = PAGE_SECTION5;
    [self.contentView bringSubviewToFront:_scrollViewSection1];
}
- (IBAction)section4Clicked:(id)sender {
    
    [_section1 setSelected:NO];
    [_section2 setSelected:NO];
    [_section3 setSelected:NO];
    [_section4 setSelected:YES];
    [_section5 setSelected:NO];
    [_section6 setSelected:NO];
    
    _scrollViewSection1.contentOffset = CGPointMake(_scrollViewSection1.frame.size.width*10, 0);
    
    self.pageControl.currentPage = 10;
//    self.pageControl.numberOfPages = PAGE_SECTION7;
    [self.contentView bringSubviewToFront:_scrollViewSection1];
}
- (IBAction)section5Clicked:(id)sender {
    
    [_section1 setSelected:NO];
    [_section2 setSelected:NO];
    [_section3 setSelected:NO];
    [_section4 setSelected:NO];
    [_section5 setSelected:YES];
    [_section6 setSelected:NO];
    _scrollViewSection1.contentOffset = CGPointMake(_scrollViewSection1.frame.size.width*12, 0);
    
    self.pageControl.currentPage = 12;
//    self.pageControl.numberOfPages = PAGE_SECTION1;
    [self.contentView bringSubviewToFront:_scrollViewSection1];
}
- (IBAction)section6Clicked:(id)sender {
    [_section1 setSelected:NO];
    [_section2 setSelected:NO];
    [_section3 setSelected:NO];
    [_section4 setSelected:NO];
    [_section5 setSelected:NO];
    [_section6 setSelected:YES];
    
    _scrollViewSection1.contentOffset = CGPointMake(_scrollViewSection1.frame.size.width*13, 0);
    
    self.pageControl.currentPage = 13;
    [self.contentView bringSubviewToFront:_scrollViewSection1];
}

- (IBAction)abcEmojiViewClicked:(id)sender
{
    self.alphabeticController.rootController = self;
    
    //NORMAL PRESENTATION
    [self presentViewController:self.alphabeticController animated:NO completion:nil];
}


- (void)gotText:(NSNotification*)notification{
    [self.textDocumentProxy insertText:(NSString*)notification.object];
}

@end