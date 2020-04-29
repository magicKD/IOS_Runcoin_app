//
//  SNRunningModeDataView.m
//  RunApp
//
//  Created by BenTsai on 2019/12/17.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import "SNRunningModeDataView.h"

@interface SNRunningModeDataView ()

@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UILabel *paceLabel;

@end

@implementation SNRunningModeDataView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    
    // 标签初始默认值
    [self setDistance:0.0];
    [self setPace:0.0];
    
    self.distanceLabel.adjustsFontSizeToFitWidth = YES;
    self.paceLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setDistance:(CGFloat)distance
{
    NSString *distanceStr = [NSString stringWithFormat:@"%.2f", distance];
    [self setupLabel:self.distanceLabel prefixStr:distanceStr prefixFontSize:[self prefixFontSize] suffixStr:[self distanceSuffixString] suffixFontSize:[self suffixFontSize]];
}

- (void)setPace:(CGFloat)pace
{
    NSString *paceStr = [NSString stringWithFormat:@"%.2f", pace];
    [self setupLabel:self.paceLabel prefixStr:paceStr prefixFontSize:[self prefixFontSize] suffixStr:[self paceSuffixString] suffixFontSize:[self suffixFontSize]];
}

- (void)setupLabel:(UILabel *)label prefixStr:(NSString *)prefixStr prefixFontSize:(CGFloat)prefixFontSize suffixStr:(NSString *)suffixStr suffixFontSize:(CGFloat)suffixFontSize
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", prefixStr, suffixStr]];
    
    NSInteger prefixLength = [prefixStr length];
    NSInteger length = [attributedText length];
    
    [attributedText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:prefixFontSize] range:NSMakeRange(0, prefixLength)];
    [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:suffixFontSize] range:NSMakeRange(prefixLength, length - prefixLength)];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[self labelColor] range:NSMakeRange(0, length)];
    
    label.attributedText = attributedText;
}

- (UIColor *)labelColor
{
    return [UIColor blackColor];
}

- (NSString *)distanceSuffixString
{
    NSString *str = @"  公里";
    return str;
}

- (NSString *)paceSuffixString
{
    NSString *str = @"  配速(分/公里)";
    return str;
}

- (CGFloat)prefixFontSize
{
    CGFloat fontSize = 30;

    return fontSize;
}

- (CGFloat)suffixFontSize
{
    CGFloat fontSize = 20;
    
    return fontSize;
}

@end
