//
//  GenreToStoriesAnimationController.m
//  StoryTellersApp
//
//  Created by Mohammad Azam on 1/8/14.
//  Copyright (c) 2014 AzamSharp Consulting LLC. All rights reserved.
//

#import "GenreToStoriesAnimationController.h"


@implementation GenreToStoriesAnimationController


- (NSTimeInterval)transitionDuration:
(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:
(id <UIViewControllerContextTransitioning>)transitionContext {
    // 1. obtain state from the context
    UIViewController *toViewController = (UIViewController *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    // 2. obtain the container view
    UIView *containerView = [transitionContext containerView];
    // 3. set initial state
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    toViewController.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height); // 4. add the view
    [containerView addSubview:toViewController.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        toViewController.view.frame = finalFrame;
        
    }
                     completion:^(BOOL finished) {
            // 6. inform the context of completion
                         
            [transitionContext completeTransition:YES]; }];
}

@end
