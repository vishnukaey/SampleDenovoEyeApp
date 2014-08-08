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

@interface DEMedicationViewController (){
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
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"confirm"]){
        DEConfirmViewController *confirm=[segue destinationViewController];
        confirm.medication=mod;
    }
    if([segue.identifier isEqualToString:@"reccurence"]){
        DEReccurenceViewController *reccur=[segue destinationViewController];
        reccur.medication=mod;

        
    }
}

-(void) viewDidAppear:(BOOL)animated{
    [self.search becomeFirstResponder];
}
- (IBAction)pushToReccurenceController:(id)sender {
    [self performSegueWithIdentifier:@"reccurence" sender:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self go:self];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
