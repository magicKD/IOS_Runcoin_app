//
//  SNCountdownView.h
//  RunApp
//
//  Created by BenTsai on 2019/12/17.
//  Copyright © 2019 MOSAD10. All rights reserved.
//

#ifndef SNCountdownViewController_h
#define SNCountdownViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//回调函数用于通知倒计时结束
@protocol SNCountdownViewDelegate <NSObject>

- (void)countdownFinish;

@end

@interface SNCountdownView : UIView

@property (nonatomic, weak) id<SNCountdownViewDelegate> delegate;

- (void)startCountdownWithTime:(NSInteger)time;
- (void)startAnimationCountdownWithTime:(NSInteger)time;

@end


#endif /* SNCountdownViewController_h */
