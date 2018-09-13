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

#define FULLTIME 60.0
#define HALFTIME 30.0
#define HALFTIMEBEEP (HALFTIME + 1.0)

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
    
    myStopWatch = [self createTimer];
    [self resetTimer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (touch.view.tag == 1) {
        [self resetTimer];
        return;
    }
    
    [self startStopTimer];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if ([[touch.view class] isSubclassOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)touch.view;
        if (CGRectContainsPoint(label.frame, touchLocation)) {
            dragging = YES;
            oldX = touchLocation.x;
            oldY = touchLocation.y;
        }
    }
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    dragging = NO;
}

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

- (NSTimer*)createTimer {
    
    // create timer on run loop
    return [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
}


- (void)resetTimer {

    running = NO;
    expired = NO;
    halfTimeSounded = NO;
    displayTime = FULLTIME;
    startTime = 0;
    currentTime = 0;
    currentDuration = 0.0;
    
    extraDuration = 0.0;
    totalDuration = 0.0;

     AudioServicesPlaySystemSound(1105);
    
    [self setGUI];
}


- (void)startStopTimer {

    if (self->expired) {
        AudioServicesPlaySystemSound(1305);
        return;
    }
    
    AudioServicesPlaySystemSound(1103);
    
    if (self->running) {
        self->running = NO;
        [self setGUI];
        return;
    }
    self->running = YES;
    extraDuration += currentDuration;
    currentDuration = 0;
    self->startTime = CACurrentMediaTime();

    [self setGUI];
}


- (void)timerTicked:(NSTimer*)timer {
    
    if (self->expired) {
        return;
    }
    if (!self->running) {
        return;
    }

    currentTime = CACurrentMediaTime();
    currentDuration =  currentTime - startTime;
    totalDuration = extraDuration + currentDuration;
    
    displayTime = FULLTIME - totalDuration;

    if (displayTime <= HALFTIMEBEEP) {
        if (!halfTimeSounded) {
            AudioServicesPlaySystemSound(4095);
            halfTimeSounded = YES;
        }
    }
    
    if (displayTime <= 0.0) {
        displayTime = 0.0;
        expired = YES;
        running = NO;
        AudioServicesPlaySystemSound(1304);
    }

    [self setGUI];
}


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


- (void)actionStop:(id)sender {
    
    // stop the timer
    [myStopWatch invalidate];
}


@end
