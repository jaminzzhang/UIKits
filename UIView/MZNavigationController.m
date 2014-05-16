//
//  MZNavigationController.m
//  MZ
//
//  Created by Jamin on 5/16/14.
//  Copyright (c) 2014 mz. All rights reserved.
//

#import "MZNavigationController.h"

@interface MZNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation MZNavigationController

@synthesize supportPopGesture = _supportPopGesture;


#pragma mark - UINavigationController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _supportPopGesture = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 70000/*__IPHONE_7_0*/)
    __weak typeof(self) weakSelf = self;

    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        [self updatePopGestureSupport];
        self.delegate = weakSelf;
    }
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Override

//push
- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    [super setViewControllers:viewControllers animated:animated];
    [self checkNavigationBarHiddenAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (![self canPush]) {
        return;
    }

    //Prevent it pop too much
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }

    [super pushViewController:viewController animated:animated];
    [self checkNavigationBarHiddenAnimated:animated];
}

//pop
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (![self canPop]) {
        return nil;
    }

    UIViewController * popedViewController = [super popViewControllerAnimated:animated];
    if (nil != popedViewController) {
        [self checkNavigationBarHiddenAnimated:animated];
    }
    return popedViewController;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (![self canPop]) {
        return nil;
    }

    NSArray * popedViewControllers = [super popToViewController:viewController animated:animated];
    if (popedViewControllers.count > 0) {
        [self checkNavigationBarHiddenAnimated:animated];
    }
    return popedViewControllers;
}


- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if (![self canPop]) {
        return nil;
    }

    NSArray * popedViewControllers = [super popToRootViewControllerAnimated:animated];
    if (popedViewControllers.count > 0) {
        [self checkNavigationBarHiddenAnimated:animated];
    }
    return popedViewControllers;
}




#pragma mark - Public
- (void)setSupportPopGesture:(BOOL)supportPopGesture
{
    if (_supportPopGesture == supportPopGesture) {
        return;
    }

    _supportPopGesture = supportPopGesture;
    [self updatePopGestureSupport];
}

/**
 *  It don't support pop gesture until there is more than one vc in navigationController stack;
 *
 *  @return whether it support pop gesture
 */
- (BOOL)supportPopGesture
{
    if (![self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        return NO;
    }

    return (_supportPopGesture && self.viewControllers.count > 1);
}


- (void)updatePopGestureSupport
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = self.supportPopGesture;
    }
    
}


#pragma mark - Private

- (BOOL)canPush
{
    return YES;
}


- (BOOL)canPop
{
    return self.viewControllers.count > 1;
}


- (void)checkChildViewControllerNavigationBarHidden:(UIViewController *)viewController
                                           animated:(BOOL)animated
{
    if ([viewController respondsToSelector:@selector(shouldHideNavigationBar)]) {
        BOOL hideNavBar = [(id<MZNavigationChildViewController>)viewController shouldHideNavigationBar];
        if (hideNavBar != self.navigationBarHidden) {
            [self setNavigationBarHidden:hideNavBar animated:animated];
        }
    }
}


- (void)checkNavigationBarHiddenAnimated:(BOOL)animated
{
    [self checkChildViewControllerNavigationBarHidden:self.topViewController animated:animated];
}



#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{

}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    //Check if it support pop gesture after push/pop
    if ([navigationController respondsToSelector:@selector(updatePopGestureSupport)]) {
        [navigationController performSelector:@selector(updatePopGestureSupport)];
    }
}



#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
{
    return self.supportPopGesture;
}


@end
