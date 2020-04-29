//
//  SNTimeLabel.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNTimeLabel : UIView

- (void)resetTimeLabelWithTotalSeconds:(NSUInteger)totalSeconds;
- (void)setLabelFontSize:(CGFloat)fontSize;

- (void)setBoldWithFontSize:(CGFloat)fontSize;

@end
