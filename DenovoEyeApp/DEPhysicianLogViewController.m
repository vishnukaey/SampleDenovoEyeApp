//
//  DEPhysicianLogViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 13/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEPhysicianLogViewController.h"

@interface DEPhysicianLogViewController ()

@end

@implementation DEPhysicianLogViewController

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
    self.photo.layer.cornerRadius = self.photo.frame.size.height / 2;
    self.photo.clipsToBounds = YES;
	self.photo.image=[UIImage imageWithData:[self.physician.photo getData]];
    self.physicianName.text=self.physician.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
