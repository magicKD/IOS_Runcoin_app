//
//  SNResultDataLabelsView.m
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import "SNResultDataLabelsView.h"
#import "SNMarkLabel.h"

@interface SNResultDataLabelsView ()

@property (nonatomic, weak) IBOutlet SNMarkLabel *distanceMarkLabel;
@property (nonatomic, weak) IBOutlet SNMarkLabel *timeMarkLabel;
@property (nonatomic, weak) IBOutlet SNMarkLabel *calorieMarkLabel;

@end

@implementation SNResultDataLabelsView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        UIView *containerView = [[[UINib nibWithNibName:@"SNResultDataLabelsView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        containerView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:containerView];
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupMarkLabel];
}

- (void)setupMarkLabel
{
    // 初始化设置标签的默认值
    CGFloat contentFontSize = 28;
    CGFloat markFontSize = 12;
    
    [self.distanceMarkLabel setContentBoldWithFontSize:contentFontSize];
    [self.timeMarkLabel setContentBoldWithFontSize:contentFontSize];
    [self.calorieMarkLabel setContentBoldWithFontSize:contentFontSize];
    
    [self.distanceMarkLabel setMarkFontSize:markFontSize];
    [self.timeMarkLabel setMarkFontSize:markFontSize];
    [self.calorieMarkLabel setMarkFontSize:markFontSize];
    
    [self.distanceMarkLabel setTextColor:[self textColor]];
    [self.timeMarkLabel setTextColor:[self textColor]];
    [self.calorieMarkLabel setTextColor:[self textColor]];
    
    [self.distanceMarkLabel setContentText:@"0.00"];
    [self.timeMarkLabel setContentText:@"00:00:00"];
    [self.calorieMarkLabel setContentText:@"0.00"];
    
    [self.distanceMarkLabel setMarkText:@"公里"];
    [self.timeMarkLabel setMarkText:@""];
    [self.calorieMarkLabel setMarkText:@"公里/分"];
}

- (void)setupWithDistance:(NSString *)distance
                     time:(NSString *)time
                  calorie:(NSString *)calorie
{
    [self.distanceMarkLabel setContentText:distance];
    [self.timeMarkLabel setContentText:time];
    [self.calorieMarkLabel setContentText:calorie];
}


- (UIColor *)textColor
{
    return [UIColor whiteColor];
}

@end
