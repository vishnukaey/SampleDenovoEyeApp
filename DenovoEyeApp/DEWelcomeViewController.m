//
//  DEWelcomeViewController.m
//  DenovoEyeApp
//
//  Created by qbadmin on 05/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEWelcomeViewController.h"

@interface DEWelcomeViewController ()

@end

@implementation DEWelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)skip:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:@"loginStatus"]){
        [self performSegueWithIdentifier:@"loginScreen" sender:self];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)login:(id)sender {
        [self performSegueWithIdentifier:@"loginScreen" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:@"loginStatus"]){
        self.login.enabled=YES;
    }
    else {
        self.login.enabled=NO;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
