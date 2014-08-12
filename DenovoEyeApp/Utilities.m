//
//  Utilities.m
//  DenovoEyeApp
//
//  Created by qbadmin on 05/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "Utilities.h"
#import <Foundation/Foundation.h>

@implementation Utilities

+ (void) showAlert:(NSString *)message withTitle:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}

@end
