//
//  XKViewController.m
//  XKCategory
//
//  Created by kunhum on 09/18/2018.
//  Copyright (c) 2018 kunhum. All rights reserved.
//

#import "XKViewController.h"
#import <UIScrollView+xkCategory.h>
#import <NSString+xkCategory.h>

@interface XKViewController ()

@end

@implementation XKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@", [NSString xk_formatterFloat:6.835 mode:NSRoundDown]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
