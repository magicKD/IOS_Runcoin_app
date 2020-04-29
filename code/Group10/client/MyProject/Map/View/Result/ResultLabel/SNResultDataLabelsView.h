//
//  SNResultDataLabelsView.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface SNResultDataLabelsView : UIView

- (void)setupWithDistance:(NSString *)distance
                     time:(NSString *)time
                  calorie:(NSString *)calorie;

@end
