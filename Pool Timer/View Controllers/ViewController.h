//
//  ViewController.h
//  Pool Timer
//
//  Created by Nick King on 13/04/2016.
//  Copyright © 2016 Maxion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {

    BOOL    running;
    BOOL    expired;
    BOOL    halfTimeSounded;

    float displayTime;      // Time currently being displayed.

    float startTime;
    float currentTime;
    
    float currentDuration;
    
    float extraDuration;
    float totalDuration;

    NSTimer *myStopWatch;

    float oldX, oldY;
    BOOL dragging;

}

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *resetLabel;

@end

