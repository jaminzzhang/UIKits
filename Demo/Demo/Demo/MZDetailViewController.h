//
//  MZDetailViewController.h
//  Demo
//
//  Created by Jamin on 5/16/14.
//  Copyright (c) 2014 mz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZNavigationController.h"

@interface MZDetailViewController : UIViewController <MZNavigationChildViewController, UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (assign, nonatomic) NSInteger itemIndex;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
