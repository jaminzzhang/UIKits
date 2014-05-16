//
//  MZNavigationController.h
//  MZ
//
//  Created by Jamin on 5/16/14.
//  Copyright (c) 2014 mz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MZNavigationChildViewController <NSObject>

@required

/**
 *  UINavigationController whould check if it should hide navigationBar while push/pop a vc,
 *  then it whould show/hide navigationBar.
 *  @return
 */
- (BOOL)shouldHideNavigationBar;

@end

@interface MZNavigationController : UINavigationController

@property (nonatomic, assign) BOOL      supportPopGesture;  //Default is YES.

/**
 *  update the support of popgesture
 */
- (void)updatePopGestureSupport;

@end
