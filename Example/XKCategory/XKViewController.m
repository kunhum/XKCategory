//
//  XKViewController.m
//  XKCategory
//
//  Created by kunhum on 09/18/2018.
//  Copyright (c) 2018 kunhum. All rights reserved.
//

#import "XKViewController.h"
#import "GTMBase64.h"

@interface XKViewController ()

@end

@implementation XKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *string = @"呵呵";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *baseData = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSData *gtmBaseData = [GTMBase64 encodeData:data];
    
    NSLog(@"%@ %@",baseData,gtmBaseData);
    
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
