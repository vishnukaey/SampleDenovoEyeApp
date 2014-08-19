//
//  DESampleViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 19/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DESampleViewController.h"
#import "DEOCPDetailCell.h"

@interface DESampleViewController (){
    NSArray *recipeImages;
}

@end

@implementation DESampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    recipeImages = [[NSArray alloc] initWithObjects:@"denovologo.png", nil];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"collection";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:20];
    recipeImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:0]];
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
