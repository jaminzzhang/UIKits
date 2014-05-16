//
//  MZDetailViewController.h
//  Demo
//
//  Created by Jamin on 5/16/14.
//  Copyright (c) 2014 mz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
