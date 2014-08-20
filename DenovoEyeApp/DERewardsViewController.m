//
//  DERewardsViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 20/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DERewardsViewController.h"

@interface DERewardsViewController (){
    NSArray *imagesInArray;
}

@end

@implementation DERewardsViewController

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
    imagesInArray = [[NSArray alloc]init];
	imagesInArray = [NSArray arrayWithObjects:@"argos.jpeg",
                   @"flipkart.jpeg", @"alibaba.jpeg",@"rediff.jpeg", nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [imagesInArray count];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"collection";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:20];
    recipeImageView.image = [UIImage imageNamed:[imagesInArray objectAtIndex:indexPath.row]];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
