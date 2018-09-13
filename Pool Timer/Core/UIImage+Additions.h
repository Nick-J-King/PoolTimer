//	UIImage+Additions.h
//
//  Assessments
//
//  Copyright (c) 2016 Internet Vision Technologies. All rights reserved.


@interface UIImage (Additions)

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)scaleToSizeWithSameAspectRatio:(CGSize)newSize;
- (UIImage *)fixOrientation;

@end
