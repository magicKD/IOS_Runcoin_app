//
//  SNResultRecordView.h
//  RunApp
//
//  Created by BenTsai on 2019/12/16.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNRunInfoModel;

@protocol SNResultRecordViewDelegate <NSObject>

@required
- (void)resultRecordViewBack;
@end

@interface SNResultRecordView : UIView

@property (nonatomic, weak) id<SNResultRecordViewDelegate> delegate;

- (void)setupRecordWith:(SNRunInfoModel *)runInfoModel;

@end
