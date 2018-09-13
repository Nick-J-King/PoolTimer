//	UIColor+Scheme.h
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


@interface UIColor (Scheme)

// Global

+ (UIColor *)schemeThemeDark;
+ (UIColor *)schemeThemeLight;
+ (UIColor *)schemeThemeShade;
+ (UIColor *)schemeThemeBright;
+ (UIColor *)schemeThemeWhite;
+ (UIColor *)schemeThemeBlack;
+ (UIColor *)schemeThemeGrey;

// Per control type

+ (UIColor *)schemeSwitchTint;
+ (UIColor *)schemeSwitchOnTint;

+ (UIColor *)schemeSectionHeading;
+ (UIColor *)schemeTableBackground;
+ (UIColor *)schemeLoginTextboxBackground;
+ (UIColor *)schemeLoginTextboxText;
+ (UIColor *)schemeLoginTextboxPlaceholder;
+ (UIColor *)schemeLoginTextboxCaret;

+ (UIColor *)schemePanels;

+ (UIColor *)schemeTextField;

+ (UIColor *)schemeButton;

+ (UIColor *)schemeCompleteBackground;
+ (UIColor *)schemeIncompleteBackground;

+ (UIColor *)schemePickerBackground;

+ (UIColor *)schemeTransparentNav;

@end
