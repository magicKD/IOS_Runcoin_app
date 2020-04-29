//
//  SNMarkLabel.m
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import "SNMarkLabel.h"

@interface SNMarkLabel ()

@property (nonatomic, weak) IBOutlet UILabel *contentLabel;
@property (nonatomic, weak) IBOutlet UILabel *markLabel;

@end

@implementation SNMarkLabel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        UIView *containerView = [[[UINib nibWithNibName:@"SNMarkLabel" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        
        self.contentLabel.adjustsFontSizeToFitWidth = YES;
        self.contentLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:containerView];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setContentText:(NSString *)text
{
    self.contentLabel.text = text;
}

- (void)setMarkText:(NSString *)text
{
    self.markLabel.text = text;
}

- (void)setContentFontSize:(CGFloat)size
{
    self.contentLabel.font = [UIFont systemFontOfSize:size];
}

- (void)setContentBoldWithFontSize:(CGFloat)fontSize
{
    self.contentLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:fontSize];
}

- (void)setMarkFontSize:(CGFloat)size
{
    self.markLabel.font = [UIFont systemFontOfSize:size];
}

- (void)setContentTextColor:(UIColor *)color
{
    self.contentLabel.textColor = color;
}

- (void)setMarkTextColor:(UIColor *)color
{
    self.markLabel.textColor = color;
}

- (void)setContentAttributedText:(NSAttributedString *)attributedText
{
    self.contentLabel.attributedText = attributedText;
}

- (void)setTextColor:(UIColor *)color
{
    [self setContentTextColor:color];
    [self setMarkTextColor:color];
}

@end
