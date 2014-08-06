//
//  DELoginViewController.m
//  DenovoEyeApp
//
//  Created by qbadmin on 05/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DELoginViewController.h"

@interface DELoginViewController ()

@end

@implementation DELoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}
- (IBAction)login:(id)sender {
    if([self.username.text isEqualToString:@"user"] && [self.password.text isEqualToString:@"password"]){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"loginStatus"];
        [defaults synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [Utilities showAlert:@"Wrong Credentials" withTitle:@"Failure"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
