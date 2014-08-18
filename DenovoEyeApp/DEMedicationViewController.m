//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.

#import "DEMedicationViewController.h"
#import "ParseMedicationDBModal.h"
#import "DEConfirmViewController.h"
#import "DEReccurenceViewController.h"
#import "LEColorPicker.h"

@interface DEMedicationViewController ()<DEConfirmViewControllerDelegate>{
    UIImage *drugImage;
    ParseMedicationDBModal *mod;
}

@end

@implementation DEMedicationViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.capColorView.hidden=YES;
}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.search becomeFirstResponder];
}


-(void) pushToNextViewController{
    self.capColorView.hidden=NO;
}


- (IBAction)go:(id)sender {
    self.search.enabled=NO;
    [self.search resignFirstResponder];
    PFQuery *query=[ParseMedicationDBModal query];
    [query whereKey:@"drugName" equalTo:self.search.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(objects.count!=0){
            mod=[objects objectAtIndex:0];
            NSLog(@"%@",mod.drugName);
            [mod.drugImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                drugImage=[UIImage imageWithData:data];
                mod.drugImageData=[mod.drugImage getData];
                drugImage=[UIImage imageWithData:mod.drugImageData];
                [self performSegueWithIdentifier:@"confirm" sender:self];
                LEColorPicker *colorPicker = [[LEColorPicker alloc] init];
                LEColorScheme *colorScheme = [colorPicker colorSchemeFromImage:drugImage];
                self.capColorView.backgroundColor = [colorScheme primaryTextColor];
                self.confirmColorButton.tintColor=[colorScheme backgroundColor];
                }
             ];
        }
        else{
            [Utilities showAlert:@"No Matches" withTitle:@"Sorry"];
        }
        self.search.enabled=YES;
    }];
}



- (IBAction)pushToReccurenceController:(id)sender {
    [self performSegueWithIdentifier:@"reccurence" sender:self];
}


- (IBAction)confirmColorButtonAction:(id)sender {
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"confirm"]){
        
        DEConfirmViewController *confirm=[segue destinationViewController];
        confirm.medication=mod;
        confirm.delegate=self;
    }
    if([segue.identifier isEqualToString:@"reccurence"]){
        DEReccurenceViewController *reccur=[segue destinationViewController];
        reccur.medication=mod
        ;
        
        
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self go:self];
    return YES;
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
