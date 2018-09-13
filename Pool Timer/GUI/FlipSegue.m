//	FlipSegue.m
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


#import "FlipSegue.h"


@implementation FlipSegue


// Override the default implementation to make the transition flip horizontally.

- (void)perform {

    UIViewController *destinationVC = self.destinationViewController;
    
    destinationVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    [super perform];
}


@end
