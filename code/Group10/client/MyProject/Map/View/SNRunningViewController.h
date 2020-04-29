//
//  SNRunningViewController.h
//  RunApp
//
//  Created by BenTsai on 2019/12/17.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#ifndef SNRunningViewController_h
#define SNRunningViewController_h

#import <UIKit/UIKit.h>

@protocol SNRunningViewControllerDelegate <NSObject>

@required
- (void)runningRecordFinish;

@end

@interface SNRunningViewController : UIViewController

@property (nonatomic, weak) id<SNRunningViewControllerDelegate> delegate;
- (void) finishRunning;

@end

#endif /* SNRunningViewController_h */
