//
//  ViewController.m
//  Pool Timer
//
//  Created by Nick King on 13/04/2016.
//  Copyright © 2016 Maxion. All rights reserved.
//

#import "ViewController.h"
#import "Utils.h"
#import "AdjustableLabel.h"

#define FULLTIME 60.0                   // Seconds to start countdown timer.
#define HALFTIME 30.0                   // Seconds to switch to "halftime" mode.
#define HALFTIMEBEEP (HALFTIME + 1.0)   // Seconds at which to vibrate to indicate "halftime" mode.

@import QuartzCore;
@import AudioToolbox;
#import <AudioToolbox/AudioToolbox.h>


@interface ViewController ()

@end


@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
    
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    
    myStopWatch = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
        // Start the tick events.
    
    [self resetTimer:false go:false];
        // Simulate an initial reset - timer is stopped.
}


// The user hit the "reset" button.
// Reset to full time (60 seconds) and put in "stopped" mode.
- (void)resetTimer:(BOOL)playSound go:(BOOL)go {
    
    running = go;
    expired = NO;
    halfTimeSounded = NO;
    
    displayTime = FULLTIME;
    
    touchStartTime = 0;
    if (go) {
        fromTime = CACurrentMediaTime();
        currentTime = CACurrentMediaTime();
    }
    else {
        fromTime = 0;
        currentTime = 0;
    }
    currentDuration = 0.0;
    
    accumulatedDuration = 0.0;
    totalDuration = 0.0;
    
    if (playSound) {
        AudioServicesPlaySystemSound(1105);
    }

    [self setGUI];
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    
    touchStartTime = CACurrentMediaTime();
    
    UITouch *touch = [[event allTouches] anyObject];

    // If we even hit Reset, simple.
    // Reset timer, putting it in stopped mode at 60 seconds.
    if (touch.view.tag == 1) {
        [self resetTimer:true go:false];
        return;
    }
    
    // Here, we assume the main button was pressed.
    CGPoint touchLocation = [touch locationInView:touch.view];
    startX = touchLocation.x;
    startY = touchLocation.y;
    
    
    // If the countdown has already expired, don't do anything but play a warning tone.
    // Must reset manually after a "time foul". Play a "blerp" sound.
    if (self->expired) {
        AudioServicesPlaySystemSound(1305);
        return;
    }
    dragging = YES;

    AudioServicesPlaySystemSound(1103);
        // Play a "tink" sound.
    
    if (self->running) {
        // The timer was running.
        // Want to pause the timer, immediately.
        // If the user holds the button long enough, the timer will reset and restart when released.
        self->running = NO;
        [self setGUI];
        return;
    }
    
    // The timer was not running.
    // Begin/resume it immediately!
    self->running = YES;
    
    // Get the accumulated duration, and begin a new time-span.
    accumulatedDuration += currentDuration;
    currentDuration = 0;
    self->currentTime = CACurrentMediaTime();  // Record when we are starting this span from.
    self->fromTime = self->currentTime;

    [self setGUI];
}


// When a touch ends, we may wish to:
//  Reset timer and count down from 60 again, if the touch was held long enough, (and the touch did not move far.)
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    
    // Here, we assume the main button was pressed.
    CGPoint touchLocation = [touch locationInView:touch.view];
    float endX = touchLocation.x;
    float endY = touchLocation.y;
     
    if (dragging) {
        dragging = FALSE;
        if (((startX - endX) * (startX - endX) + (startY - endY) * (startY - endY)) > 100.0) {
            return; // Moved finger - don't reset!
        }
        if (CACurrentMediaTime() - touchStartTime > 1.0) {
            [self resetTimer:TRUE go:TRUE];
        }
    }
}


/*
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if ([[touch.view class] isSubclassOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)touch.view;
        
        if (dragging) {
            CGRect frame = label.frame;
            frame.origin.x = label.frame.origin.x + touchLocation.x - oldX;
            frame.origin.y =  label.frame.origin.y + touchLocation.y - oldY;
            label.frame = frame;
        }
        
    }
}
*/


// Handle the timer tick event...
// fromTime and accumulatedDuration never change here - only in the tap events.
- (void)timerTicked:(NSTimer*)timer {
    
    if (self->expired) {
        return;
    }
    if (!self->running) {
        return;
    }

    currentTime = CACurrentMediaTime();                 // Current time in seconds.
    currentDuration =  currentTime - fromTime;          // Current time in this time-span.
    
    totalDuration = accumulatedDuration + currentDuration;
    
    displayTime = FULLTIME - totalDuration;

    // Play half-time beep if needed.
    if (displayTime <= HALFTIMEBEEP) {
        if (!halfTimeSounded) {
            AudioServicesPlaySystemSound(4095);
            halfTimeSounded = YES;
        }
    }
    
    // Set as expired and play expired beep, if required.
    if (displayTime <= 0.0) {
        displayTime = 0.0;
        expired = YES;
        running = NO;
        AudioServicesPlaySystemSound(1304);
    }

    [self setGUI];
}


// We have the state of the Timer.
// Set the GUI accordingly...
- (void)setGUI {

    _timeLabel.text = [NSString stringWithFormat:@" %04.1f ", displayTime];
    
    // Expired is red

    if (expired) {
        _timeLabel.backgroundColor = UIColorFromRGB(230,10,20);
        return;
    }

    // Not running is pale green / yellow

    if (!running) {
        if (displayTime > HALFTIME) {
            _timeLabel.backgroundColor = UIColorFromRGB(50,130,50);
        }
        else {
            _timeLabel.backgroundColor = UIColorFromRGB(130,130,50);
        }
        return;
    }
    
    // Running is bright green / yellow

    if (displayTime > HALFTIME) {
        _timeLabel.backgroundColor = UIColorFromRGB(10,170,10);
    }
    else {
        _timeLabel.backgroundColor = UIColorFromRGB(170,170,20);
    }
}

@end
