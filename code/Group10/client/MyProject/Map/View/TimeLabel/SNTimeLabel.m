//
//  SNTimeLabel.m
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import "SNTimeLabel.h"

@interface SNTimeLabel ()

@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@end

@implementation SNTimeLabel

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initCount];
    
    self.timeLabel.text = @"00 : 00 : 00";
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)initCount
{
    self.hour = 0;
    self.minute = 0;
    self.second = 0;
}

- (void)resetTimeLabelWithTotalSeconds:(NSUInteger)totalSeconds
{
    self.hour = totalSeconds / 3600;
    self.minute = (totalSeconds - self.hour * 3600) / 60;
    self.second = totalSeconds - self.hour * 3600 - self.minute * 60;
    
    [self setupTimeLabelText];
}

- (void)setLabelFontSize:(CGFloat)fontSize
{
    self.timeLabel.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setupTimeLabelText
{
    NSString *hourText = @"";
    if (self.hour < 10)
    {
        hourText = [hourText stringByAppendingString:@"0"];
    }
    hourText = [hourText stringByAppendingString:[NSString stringWithFormat:@"%@", @(self.hour)]];
    
    NSString *minuteText = @"";
    if (self.minute < 10)
    {
        minuteText = [minuteText stringByAppendingString:@"0"];
    }
    minuteText = [minuteText stringByAppendingString:[NSString stringWithFormat:@"%@", @(self.minute)]];
    
    NSString *secondText = @"";
    if (self.second < 10)
    {
        secondText = [secondText stringByAppendingString:@"0"];
    }
    secondText = [secondText stringByAppendingString:[NSString stringWithFormat:@"%@", @(self.second)]];
    
    NSString *labelText = [NSString stringWithFormat:@"%@ : %@ : %@", hourText, minuteText, secondText];
    self.timeLabel.text = labelText;
}

- (void)setBoldWithFontSize:(CGFloat)fontSize
{
    // 设置粗体
    self.timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:fontSize];
}

@end
