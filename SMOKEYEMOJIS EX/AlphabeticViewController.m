//
//  AlphabeticViewController.m
//

#import <UIKit/UIKit.h>

#import "AlphabeticViewController.h"

#define KEYBOARD_EMOJU_MODE 0
#define KEYBOARD_ABC_MODE 1
#define KEYBOARD_SPECIAL_CHARACTERS_MODE 2
#define KEYBOARD_NUMBER_MODE 3

@interface AlphabeticViewController ()
{
    int _shiftStatus; //0 = off, 1 = on, 2 = caps lock
}

@property (weak, nonatomic) IBOutlet UIView *lettersRow1View;
@property (weak, nonatomic) IBOutlet UIView *lettersRow2View;
@property (weak, nonatomic) IBOutlet UIView *lettersRow3View;

@property (nonatomic, weak) IBOutlet UIView *numbersRow1View;
@property (nonatomic, weak) IBOutlet UIView *numbersRow2View;

@property (nonatomic, weak) IBOutlet UIView *symbolsRow1View;
@property (nonatomic, weak) IBOutlet UIView *symbolsRow2View;

@property (nonatomic, weak) IBOutlet UIView *numbersSymbolsRow3View;

@property (weak, nonatomic) IBOutlet UIButton *bcksp1;
@property (weak, nonatomic) IBOutlet UIButton *bcksp2;

//keys
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *letterButtonsArray;
@property (nonatomic, weak) IBOutlet UIButton *switchModeRow3Button;
@property (nonatomic, weak) IBOutlet UIButton *shiftButton;
@property (weak, nonatomic) IBOutlet UIButton *backspaceNormalButton;

// normal view
@property (weak, nonatomic) IBOutlet UIView *row4NormalView;
@property (weak, nonatomic) IBOutlet UIButton *spaceButton;

@property (weak, nonatomic) IBOutlet UIButton *globalNormalButton;
@property (weak, nonatomic) IBOutlet UIButton *emojiNormalButton;
@property (weak, nonatomic) IBOutlet UIButton *abcOrNumberButtonNormalView;

@property (nonatomic, strong) KeyboardViewController *testController;

@end

@implementation AlphabeticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initializeKeyboard];
    [self viewDidLayoutSubviews];
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSLog(@"Entrou aqui sozinho");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - initialization method

- (void) initializeKeyboard {
    
    //start with shift on
    _shiftStatus = 1;
    
    //initialize space key double tap
    UITapGestureRecognizer *spaceDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(spaceKeyDoubleTapped:)];
    
    spaceDoubleTap.numberOfTapsRequired = 2;
    [spaceDoubleTap setDelaysTouchesEnded:NO];
    
    [self.spaceButton addGestureRecognizer:spaceDoubleTap];
    
    //initialize shift key double and triple tap
    UITapGestureRecognizer *shiftDoubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shiftKeyDoubleTapped:)];
    UITapGestureRecognizer *shiftTripleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shiftKeyPressed:)];
    
    shiftDoubleTap.numberOfTapsRequired = 2;
    shiftTripleTap.numberOfTapsRequired = 3;
    
    [shiftDoubleTap setDelaysTouchesEnded:NO];
    [shiftTripleTap setDelaysTouchesEnded:NO];
    
    [self.shiftButton addGestureRecognizer:shiftDoubleTap];
    [self.shiftButton addGestureRecognizer:shiftTripleTap];
    

    self.abcOrNumberButtonNormalView.tag = KEYBOARD_NUMBER_MODE;
}


#pragma mark - key methods


- (IBAction) globeKeyPressed:(id)sender {
    
    [self.rootController advanceToNextInputMode];
}

- (IBAction) keyPressed:(UIButton*)sender {
    
    NSLog(@"Pressed key: %@ \n",sender.titleLabel.text);
    
    [self.rootController.textDocumentProxy insertText:sender.titleLabel.text];
    
    if (_shiftStatus == 1) {
        [self shiftKeyPressed:self.shiftButton];
    }
}

-(IBAction) backspaceKeyPressed: (UIButton*) sender {
    
    [self.rootController.textDocumentProxy deleteBackward];
}


-(IBAction) spaceKeyPressed: (UIButton*) sender {
    
      [self.rootController.textDocumentProxy insertText:@" "];
}

-(void) spaceKeyDoubleTapped: (UIButton*) sender {
    
    [self.rootController.textDocumentProxy deleteBackward];
    [self.rootController.textDocumentProxy insertText:@". "];
    
    if (_shiftStatus == 0) {
        [self shiftKeyPressed:self.shiftButton];
    }
}


-(IBAction) returnKeyPressed: (UIButton*) sender {
    
    //[self.textDocumentProxy insertText:@"\n"];
    [self.rootController.textDocumentProxy insertText:@"\n"];
}


-(IBAction) shiftKeyPressed: (UIButton*) sender {
    
    _shiftStatus = _shiftStatus > 0 ? 0 : 1;
    
    [self shiftKeys];
}


-(void) shiftKeyDoubleTapped: (UIButton*) sender {
    
    //set shift to caps lock and set all letters to uppercase
    _shiftStatus = 2;
    
    [self shiftKeys];
    
}


- (void) shiftKeys {
    
    //if shift is off, set letters to lowercase, otherwise set them to uppercase
    if (_shiftStatus == 0) {
        for (UIButton* letterButton in self.letterButtonsArray) {
            [letterButton setTitle:letterButton.titleLabel.text.lowercaseString forState:UIControlStateNormal];
        }
    } else {
        for (UIButton* letterButton in self.letterButtonsArray) {
            [letterButton setTitle:letterButton.titleLabel.text.uppercaseString forState:UIControlStateNormal];
        }
    }
    
    //adjust the shift button images to match shift mode
    NSString *shiftButtonImageName = [NSString stringWithFormat:@"SHIFT_%i_TabIcon.png", _shiftStatus];
    [self.shiftButton setImage:[UIImage imageNamed:shiftButtonImageName] forState:UIControlStateNormal];
    
    
    NSString *shiftButtonHLImageName = [NSString stringWithFormat:@"SHIFT_%i_TabIcon_active.png", _shiftStatus];
    [self.shiftButton setImage:[UIImage imageNamed:shiftButtonHLImageName] forState:UIControlStateHighlighted];
    
}


- (IBAction) switchKeyboardMode:(UIButton*)sender {
    
    self.lettersRow1View.hidden = YES;
    self.lettersRow2View.hidden = YES;
    self.lettersRow3View.hidden = YES;
    
    self.numbersRow1View.hidden = YES;
    self.numbersRow2View.hidden = YES;
    
    self.symbolsRow1View.hidden = YES;
    self.symbolsRow2View.hidden = YES;
    
    self.numbersSymbolsRow3View.hidden = YES;
    
    switch (sender.tag) {
            
        case KEYBOARD_ABC_MODE: {
            self.lettersRow1View.hidden = NO;
            self.lettersRow2View.hidden = NO;
            self.lettersRow3View.hidden = NO;
            
            //            self.emojiView.hidden = YES;
            
            [self.abcOrNumberButtonNormalView setImage:[UIImage imageNamed:@"123_TabIcon.png"] forState:UIControlStateNormal];
            [self.abcOrNumberButtonNormalView setImage:[UIImage imageNamed:@"123_TabIcon_active.png"] forState:UIControlStateHighlighted];
            self.abcOrNumberButtonNormalView.tag = KEYBOARD_NUMBER_MODE;
        }
            break;
            
        case KEYBOARD_SPECIAL_CHARACTERS_MODE: {
            self.symbolsRow1View.hidden = NO;
            self.symbolsRow2View.hidden = NO;
            self.numbersSymbolsRow3View.hidden = NO;
            
            [self.switchModeRow3Button setImage:[UIImage imageNamed:@"123_TabIcon.png"] forState:UIControlStateNormal];
            [self.switchModeRow3Button setImage:[UIImage imageNamed:@"123_TabIcon_active.png"] forState:UIControlStateHighlighted];
            self.switchModeRow3Button.tag = 3;
        }
            break;
            
        case KEYBOARD_NUMBER_MODE: {
            //show numbers view, smile button, tag equal to 0 and symbols tags.
            
            self.numbersRow1View.hidden = NO;
            self.numbersRow2View.hidden = NO;
            self.numbersSymbolsRow3View.hidden = NO;
            
            [self.switchModeRow3Button setImage:[UIImage imageNamed:@"SYMBOLS_TabIcon.png"] forState:UIControlStateNormal];
            [self.switchModeRow3Button setImage:[UIImage imageNamed:@"SYMBOLS_TabIcon_active.png"] forState:UIControlStateHighlighted];
            self.switchModeRow3Button.tag = 2;
            
            [self.abcOrNumberButtonNormalView setImage:[UIImage imageNamed:@"ABC_TabIcon.png"] forState:UIControlStateNormal];
            [self.abcOrNumberButtonNormalView setImage:[UIImage imageNamed:@"ABC_TabIcon_active.png"] forState:UIControlStateHighlighted];
            self.abcOrNumberButtonNormalView.tag = KEYBOARD_ABC_MODE;
        }
            break;
            
        default:
            
            break;
    }
    
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    if([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height){
        self.globalNormalButton.imageView.contentMode = UIViewContentModeCenter;
        self.emojiNormalButton.imageView.contentMode = UIViewContentModeCenter;
        self.abcOrNumberButtonNormalView.imageView.contentMode = UIViewContentModeCenter;
        
        self.shiftButton.imageView.contentMode = UIViewContentModeCenter;
        self.bcksp1.imageView.contentMode = UIViewContentModeCenter;
        self.bcksp2.imageView.contentMode = UIViewContentModeCenter;
        self.switchModeRow3Button.imageView.contentMode = UIViewContentModeCenter;
    }
}


#pragma mark - IBAction for row 4 normal
- (IBAction)emojiNormalViewClicked:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
