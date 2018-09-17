//
//  ViewController.h
//  Pool Timer
//
//  Created by Nick King on 13/04/2016.
//  Copyright © 2016 Maxion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {

    BOOL    running;            // Whether the timer is running.
    BOOL    expired;            // Whether the timer has expired.
    BOOL    halfTimeSounded;    // Whether the half-time beep/vibration has sounded.

    float touchStartTime;
    
    float fromTime;         // Time current span started.
    float currentTime;      // Current time "now".
    float currentDuration;  // The current duration (currentTime - fromTime).
    
    float accumulatedDuration;  // Any accumulated time from the previous time-span (if any).
                                // This is calculated whenever the timer is paused.
    
    float totalDuration;    // The total duration in seconds that have been counted.

    float displayTime;      // Time currently being displayed (rounded version of 60 - totalDuration).

    NSTimer *myStopWatch;   // Timer used to create tick events.

    float startX, startY;   // Record when tap begins to check if a swipe is performed.
    BOOL dragging;          // Whether the ...
}

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *resetLabel;

@end

