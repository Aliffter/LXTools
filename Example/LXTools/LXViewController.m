//
//  LXViewController.m
//  LXTools
//
//  Created by Aliffter on 09/27/2022.
//  Copyright (c) 2022 Aliffter. All rights reserved.
//

#import "LXViewController.h"
#import "LXUILib.h"
#import "Localisator.h"
@interface LXViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation LXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLab.text = NSLocalizedString(@"label",nil);

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [LXUILib test];
}

@end
