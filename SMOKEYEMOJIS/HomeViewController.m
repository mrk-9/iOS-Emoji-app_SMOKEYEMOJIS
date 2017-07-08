//
//  HomeViewController.m
//  SMOKEYEMOJIS
//
//  Created by Fedoro on 3/18/16.
//  Copyright © 2016 Hoang. All rights reserved.
//

#import "HomeViewController.h"
#import "GuideViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn_more;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.btn_more.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.btn_more.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)guideViewAction:(id)sender {
    
    GuideViewController * guideViewController = [[GuideViewController alloc] init];
    [self presentViewController:guideViewController animated:NO completion:nil];
}

@end
