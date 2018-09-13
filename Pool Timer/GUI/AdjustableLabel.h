@interface AdjustableLabel : UILabel
/** 
  If set to YES, font size will be automatically adjusted to frame.
  Note: numberOfLines can't be specified so it will be set to 0.
*/
@property(nonatomic) BOOL adjustsFontSizeToFitFrame;
@end