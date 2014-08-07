//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.

#import "DEMedicationViewController.h"
#import "ParseMedicationDBModal.h"
#import "DEConfirmViewController.h"

@interface DEMedicationViewController ()<DEConfirmViewControllerDelegate>{
    UIImage *drugImage;
    ParseMedicationDBModal *mod;
}

@end

@implementation DEMedicationViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
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
                [self performSegueWithIdentifier:@"confirm" sender:self];
            }
             ];
        }
        else{
            [Utilities showAlert:@"No Matches" withTitle:@"Sorry"];
        }
        self.search.enabled=YES;
        self.search.text=@"";
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    DEConfirmViewController *confirm=[[DEConfirmViewController alloc]init];
    confirm.delegate=self;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DEConfirmViewController *confirm=[segue destinationViewController];
    confirm.delegate=self;
    confirm.medication=mod;
}

-(void)popToMedication{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)pushToReccurenceController:(id)sender {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self go:self];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
