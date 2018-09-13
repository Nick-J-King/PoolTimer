//  UIButton+Additions.m
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


#import "UIButton+Additions.h"

#import "UIImage+Additions.h"
#import "UIColor+Scheme.h"


@implementation UIButton(Additions)


- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {

    [self setBackgroundImage:[UIImage imageWithColor:color] forState:state];
}


+ (UIButton *)makeAnswerButton:(NSString *)title atXPos:(NSInteger)xPos ofWidth:(NSInteger)width {
    
    UIButton *button;
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius = 3;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor schemeButton].CGColor;
    
    button.clipsToBounds = YES;
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = CGRectMake(xPos, 7, width, 35);

    [button setTitleColor:[UIColor schemeButton] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor schemeThemeWhite] forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor schemeThemeWhite] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor schemeThemeWhite] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor schemeThemeWhite] forState:(UIControlStateHighlighted | UIControlStateSelected)];
    
    [button setBackgroundColor:[UIColor schemeThemeWhite] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor schemeThemeGrey] forState:UIControlStateDisabled];
    [button setBackgroundColor:[UIColor schemeButton] forState:UIControlStateSelected];
    [button setBackgroundColor:[UIColor schemeThemeBright] forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor schemeThemeLight] forState:(UIControlStateHighlighted | UIControlStateSelected)];
    
    return button;
}


+ (BOOL)resetButtonsExcept:(UIButton *)buttonOn {
    
    BOOL alreadySelected = NO;
    
    UIView *parentView = buttonOn.superview;
    
    for (UIView *subView in parentView.subviews) {
        
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subView;
            if (buttonOn == button && (button.state & UIControlStateSelected)) {
                alreadySelected = YES;
                [button setSelected:NO];
            }
            else {
                [button setSelected:(button == buttonOn)];
            }
        }
    }
    return alreadySelected;
}


@end