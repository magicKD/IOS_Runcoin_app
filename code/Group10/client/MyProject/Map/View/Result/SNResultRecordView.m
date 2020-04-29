//
//  SNResultRecordView.m
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import "SNResultRecordView.h"
#import "SNRunInfoModel.h"
#import "SNTimeFunc.h"
#import "SNResultDataLabelsView.h"

@interface SNResultRecordView ()

@property (nonatomic, weak) IBOutlet UIImageView *bgImageView;

@property (nonatomic, weak) IBOutlet SNResultDataLabelsView *resultDataLabelsView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *labelsViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *CoinLabel;

@end

@implementation SNResultRecordView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        UIView *containerView = [[[UINib nibWithNibName:@"SNResultRecordView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        containerView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:containerView];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addBackgroundPhoto];
    
}


- (void)addBackgroundPhoto
{
    UIImage *image = [UIImage imageNamed:@"background_image2.png"];
    
    self.bgImageView.image = image;
}

- (void)setupRecordWith:(SNRunInfoModel *)runInfoModel
{
    [self showDataLabelsWithRunInfoModel:runInfoModel];
    
}


- (void)showDataLabelsWithRunInfoModel:(SNRunInfoModel *)runInfoModel
{
    
    CGFloat kilometre = runInfoModel.distance;
    NSString *timeStr = [SNTimeFunc timeStrFromUseTime:runInfoModel.useTime];
    CGFloat calorie = kilometre / runInfoModel.useTime * 60;
    NSString *distanceStr = [NSString stringWithFormat:@"%.2f", kilometre];
   
    NSString *calorieStr = [NSString stringWithFormat:@"%@", @((NSInteger)calorie)];

    [self.resultDataLabelsView setupWithDistance:distanceStr time:timeStr calorie:calorieStr];
    
    self.CoinLabel.text = [NSString stringWithFormat:@"%d", (int)kilometre];
}

- (IBAction)back:(id)sender
{
    [self.delegate resultRecordViewBack];
}

@end
