#import "AdjustableLabel.h"

@interface AdjustableLabel ()
@property(nonatomic) BOOL fontSizeAdjusted;
@end

// The size found S satisfies: S fits in the frame and and S+DELTA doesn't.
#define DELTA 0.5

@implementation AdjustableLabel

- (void)setAdjustsFontSizeToFitFrame:(BOOL)adjustsFontSizeToFitFrame
{
    _adjustsFontSizeToFitFrame = adjustsFontSizeToFitFrame;

    if (adjustsFontSizeToFitFrame) {
        self.numberOfLines = 0; // because boundingRectWithSize works like this was 0 anyway
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (self.adjustsFontSizeToFitFrame && !self.fontSizeAdjusted)
    {
        self.fontSizeAdjusted = YES; // to avoid recursion, because adjustFontSizeToFrame will trigger this method again

        [self adjustFontSizeToFrame];

    }
}

- (void) adjustFontSizeToFrame
{
    UILabel* label = self;

    if (label.text.length == 0) return;

    CGSize labelSize = label.frame.size;

    // Fit label width-wise
    CGSize constraintSize = CGSizeMake(MAXFLOAT,100);

    // Try all font sizes from largest to smallest font size
    CGFloat maxFontSize = 700;
    CGFloat minFontSize = 5;

    NSString* text = label.text;
    UIFont* font = label.font;

    while (true)
    {
        // Binary search between min and max
        CGFloat fontSize = (maxFontSize + minFontSize) / 2;

        // Exit if approached minFontSize enough
        if (fontSize - minFontSize < DELTA/2) {
            font = [UIFont fontWithName:font.fontName size:minFontSize];
            break; // Exit because we reached the biggest font size that fits
        } else {
            font = [UIFont fontWithName:font.fontName size:fontSize];
        }

        // Find label size for current font size
        CGRect rect = [text boundingRectWithSize:constraintSize
                                         options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName : font}
                                         context:nil];

        // Now we discard a half
        if( rect.size.height <= labelSize.height && (rect.size.width <= labelSize.width) ) {
            minFontSize = fontSize; // the best size is in the bigger half
        } else {
            maxFontSize = fontSize; // the best size is in the smaller half
        }
    }

    label.font = font;
}

@end