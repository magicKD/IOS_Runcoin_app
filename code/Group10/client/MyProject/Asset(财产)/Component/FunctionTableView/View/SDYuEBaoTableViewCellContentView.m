//
//  SDYuEBaoTableViewCellContentView.m
//  MyProject
//
//  Created by apple on 2019/12/18.
//  Copyright © 2019 berchina. All rights reserved.
//

#import "SDYuEBaoTableViewCellContentView.h"

@implementation SDYuEBaoTableViewCellContentView
{
    NSTimer *_yesterdayIncomeLabelAnimationTimer;
    NSTimer *_totalMoneyAmountLabelAnimationTimer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    SDYuEBaoTableViewCellContentView *view = [[[NSBundle mainBundle] loadNibNamed:@"SDYuEBaoTableViewCellContentView" owner:nil options:nil] lastObject];
    view.yesterdayIncomeLabel.text = @"0.00";
    view.totalMoneyAmountLabel.text = @"0.00";
    return view;
}

- (void)setYesterdayIncome:(float)yesterdayIncome
{
    _yesterdayIncome = yesterdayIncome;
    
    [self setNumberTextOfLabel:self.yesterdayIncomeLabel WithAnimationForValueContent:yesterdayIncome];
}

- (void)setTotalMoneyAmount:(float)totalMoneyAmount
{
    _totalMoneyAmount = totalMoneyAmount;
    
    [self setNumberTextOfLabel:self.totalMoneyAmountLabel WithAnimationForValueContent:totalMoneyAmount];
}

- (void)setNumberTextOfLabel:(UILabel *)label WithAnimationForValueContent:(CGFloat)value
{
    CGFloat lastValue = [label.text floatValue];
    CGFloat delta = value - lastValue;
    if (delta == 0) return;
    
    if (delta > 0) {
        
        CGFloat ratio = value / 60.0;
        
        NSDictionary *userInfo = @{@"label" : label,
                                   @"value" : @(value),
                                   @"ratio" : @(ratio)
                                   };
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(setupLabel:) userInfo:userInfo repeats:YES];
        if (label == self.yesterdayIncomeLabel) {
            _yesterdayIncomeLabelAnimationTimer = timer;
        } else {
            _totalMoneyAmountLabelAnimationTimer = timer;
        }
    }
}



- (void)setupLabel:(NSTimer *)timer
{
    NSDictionary *userInfo = timer.userInfo;
    UILabel *label = userInfo[@"label"];
    CGFloat value = [userInfo[@"value"] floatValue];
    CGFloat ratio = [userInfo[@"ratio"] floatValue];

    static int flag = 1;
    CGFloat lastValue = [label.text floatValue];
    CGFloat randomDelta = (arc4random_uniform(2) + 1) * ratio;
    CGFloat resValue = lastValue + randomDelta;
    
    if ((resValue >= value) || (flag == 50)) {
        label.text = [NSString stringWithFormat:@"%.2f", value];
        flag = 1;
        [timer invalidate];
        timer = nil;
        return;
    } else {
        label.text = [NSString stringWithFormat:@"%.2f", resValue];
    }
    
    flag++;

}


@end
