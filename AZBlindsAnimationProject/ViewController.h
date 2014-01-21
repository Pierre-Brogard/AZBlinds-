//
//  ViewController.h
//  AZBlindsAnimationProject
//
//  Created by Mohammad Azam on 1/19/14.
//  Copyright (c) 2014 AzamSharp Consulting LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Additions.h"
#import "GenreToStoriesAnimationController.h"
#import "StoriesViewController.h"

@interface ViewController : UIViewController
{
    NSArray *_colors;
    NSArray *_titles; 
    int _index;
    int _selectedIndex; 
    int _barrierVerticalMargin;
    NSMutableArray *_genreViews;
    NSMutableArray *_barrierViews;
    
    
    UIDynamicAnimator *_animator;
    UIGravityBehavior *_gravity;
    UICollisionBehavior *_collision;
    UIAttachmentBehavior *_attachment;
    UIPushBehavior *_push;
    UISnapBehavior *_snap;
    
    GenreToStoriesAnimationController *_genreToStoriesAnimationController;

}
@end
