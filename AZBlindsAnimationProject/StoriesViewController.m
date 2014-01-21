//
//  StoriesViewController.m
//  AZBlindsAnimationProject
//
//  Created by Mohammad Azam on 1/19/14.
//  Copyright (c) 2014 AzamSharp Consulting LLC. All rights reserved.
//

#import "StoriesViewController.h"

@interface StoriesViewController ()

@end

@implementation StoriesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
