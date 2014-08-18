    //
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEConfirmViewController.h"

@interface DEConfirmViewController ()

@end

@implementation DEConfirmViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (IBAction)confirm:(id)sender {
    [self.delegate showCapColorView];
    [self dismissViewControllerAnimated:YES completion:Nil];
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
        self.drugImage.image=[UIImage imageWithData:self.medication.drugImageData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
