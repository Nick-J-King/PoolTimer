//	UIColor+Scheme.m
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


#import "UIColor+Scheme.h"

#import "Utils.h"


@implementation UIColor (Scheme)


#pragma mark - Global


+ (UIColor *)schemeThemeDark {
    return UIColorFromRGB(11,99,148);
}


+ (UIColor *)schemeThemeLight {
    return UIColorFromRGB(201,217,232);
}


+ (UIColor *)schemeThemeShade {
    return UIColorFromRGB(111,167,200);
}


+ (UIColor *)schemeThemeBright {
    return UIColorFromRGB(121,167,255);
}


+ (UIColor *)schemeThemeWhite {
    return UIColorFromRGB(255,255,255);
}


+ (UIColor *)schemeThemeBlack {
    return UIColorFromRGB(0,0,0);
}


+ (UIColor *)schemeThemeGrey {
    return UIColorFromRGB(200,200,200);
}


#pragma mark - Per control type


+ (UIColor *)schemeSwitchTint {
    return [UIColor schemeThemeShade];
}


+ (UIColor *)schemeSwitchOnTint {
    return [UIColor schemeThemeBright];
}


+ (UIColor *)schemeSectionHeading {
    return [UIColor schemeThemeDark];
}


+ (UIColor *)schemeTableBackground {
    return [UIColor schemeThemeLight];
}


+ (UIColor *)schemeLoginTextboxBackground {
    return [UIColor schemeThemeDark];
}


+ (UIColor *)schemeLoginTextboxText {
    return [UIColor schemeThemeWhite];
}


+ (UIColor *)schemeLoginTextboxPlaceholder {
    return UIColorFromRGB(170,170,170);
}


+ (UIColor *)schemeLoginTextboxCaret {
    return UIColorFromRGB(225,225,225);
}


+ (UIColor *)schemePanels {
    return UIColorFromRGB(224,241,255); // Extra light
}


+ (UIColor *)schemeTextField {
    return UIColorFromRGB(224,241,255); // "Bright"
}


+ (UIColor *)schemeButton {
    return [UIColor schemeThemeDark];
}


+ (UIColor *)schemeCompleteBackground {
    return [UIColor schemeThemeWhite];
}


+ (UIColor *)schemeIncompleteBackground {
    return UIColorFromRGB(230,230,230);
}


+ (UIColor *)schemePickerBackground {
    return UIColorFromRGBA(224,241,255,0.3);
}


+ (UIColor *)schemeTransparentNav {
    return UIColorFromRGBA(154,154,154,0.6);
}


@end

