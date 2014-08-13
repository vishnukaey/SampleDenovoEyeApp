//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
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
    RAC(self.login,enabled) = [RACSignal
                                combineLatest:@[ self.username.rac_textSignal, self.password.rac_textSignal]
                                reduce:^(NSString *username, NSString *password) {
                                    return @(![username isEqualToString:@""] && ![password isEqualToString:@""]);
                                }];
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
