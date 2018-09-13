//	UIButton+Additions.h
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


@interface UIButton (Additions)

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

+ (UIButton *)makeAnswerButton:(NSString *)title atXPos:(NSInteger)xPos ofWidth:(NSInteger)width;
+ (BOOL)resetButtonsExcept:(UIButton *)buttonOn;

@end