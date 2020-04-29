//
//  SNMarkLabel.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNMarkLabel : UIView

- (void)setContentText:(NSString *)text;
- (void)setMarkText:(NSString *)text;

- (void)setContentFontSize:(CGFloat)size;
- (void)setMarkFontSize:(CGFloat)size;
- (void)setContentBoldWithFontSize:(CGFloat)fontSize;

- (void)setContentTextColor:(UIColor *)color;
- (void)setMarkTextColor:(UIColor *)color;
- (void)setTextColor:(UIColor *)color;

- (void)setContentAttributedText:(NSAttributedString *)attributedText;

@end
