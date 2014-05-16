//
//  MZMasterViewController.h
//  Demo
//
//  Created by Jamin on 5/16/14.
//  Copyright (c) 2014 mz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZDetailViewController;

@interface MZMasterViewController : UITableViewController

@property (strong, nonatomic) MZDetailViewController *detailViewController;

@end
