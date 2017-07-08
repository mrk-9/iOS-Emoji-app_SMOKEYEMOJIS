//
//  KeyboardViewController.h
//  iOSKeyboardTemplate


#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "AlphabeticViewController.h"

@interface KeyboardViewController : UIInputViewController

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

-(void) testExternalFunction;

@end
