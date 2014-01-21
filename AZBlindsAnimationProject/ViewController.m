//
//  ViewController.m
//  AZBlindsAnimationProject
//
//  Created by Mohammad Azam on 1/19/14.
//  Copyright (c) 2014 AzamSharp Consulting LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (id<UIViewControllerAnimatedTransitioning>) navigationController:
(UINavigationController *)navigationController animationControllerForOperation:
(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:
(UIViewController *)toVC {
    
    return _genreToStoriesAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:
(UIViewController *)presented presentingController:
(UIViewController *)presenting sourceController: (UIViewController *)source {
    
    return _genreToStoriesAnimationController;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        _genreToStoriesAnimationController = [GenreToStoriesAnimationController new];
    }
    
    return self;
}

-(void) setup
{
     self.navigationController.delegate = self;
    
    _index = 0;
    
    _colors = [NSArray arrayWithObjects:@"380EE5",@"E5B413",@"E5AB2B",@"E52DA8",@"E52B50",@"00000D", nil];
    _titles = [NSArray arrayWithObjects:@"Fiction",@"Drama",@"Romance",@"Comedy",@"Thrillers",@"Horror", nil];
    
    _genreViews = [NSMutableArray array];
    _barrierViews = [NSMutableArray array];
    _barrierVerticalMargin = 0;
    
    [self populateGenreViews];
    [self populateBarriers];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    for(int i = 0; i<[_genreViews count];i++)
    {
        UIView *genreView = [_genreViews objectAtIndex:i];
        UIView *barrierView = [_barrierViews objectAtIndex:i];
        
        _gravity = [[UIGravityBehavior alloc] initWithItems:@[genreView]];
        [_gravity setGravityDirection:CGVectorMake(0, 1.0)];
        
        _attachment = [[UIAttachmentBehavior alloc] initWithItem:genreView attachedToAnchor:CGPointMake(self.view.center.x,100)];
        
        _collision = [[UICollisionBehavior alloc] initWithItems:@[genreView]];
        [_collision addBoundaryWithIdentifier:@"GenreBoundry" fromPoint:barrierView.frame.origin toPoint:CGPointMake(barrierView.frame.size.width, barrierView.frame.origin.y)];
        
        [_animator addBehavior:_gravity];
        [_animator addBehavior:_collision];
    }
    
}

-(void) populateBarriers
{
    for(NSString *genre in _titles)
    {
        UIView *barrier = [self createBarrier];
        [self.view addSubview:barrier];
        
        [_barrierViews addObject:barrier];
    }
    
}

-(UIView *) createBarrier
{
    UIView *barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 0)];
    barrier.center = CGPointMake(self.view.center.x, 200 + _barrierVerticalMargin);
    barrier.backgroundColor = [UIColor blackColor];
    
    _barrierVerticalMargin += 50;
    
    return barrier;
}

-(void) populateGenreViews
{
    for(NSString *title in _titles)
    {
        UIView *genreView = [self createGenreView:title];
        [_genreViews addObject:genreView];
        [self.view addSubview:genreView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UIView *) createGenreView:(NSString *) title
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    UIView *genreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    genreView.center = CGPointMake(rect.size.width/2, 0);
    genreView.tag = _index;
    
    genreView.backgroundColor = [UIColor colorFromHexString:[_colors objectAtIndex:_index]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"GeezaPro" size:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    titleLabel.tag = 1;
    [genreView addSubview:titleLabel];
    
    _index++;
    
    // register gestures
    [self registerGestures:genreView];
    
    return genreView;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"StoriesSegue"])
    {
        StoriesViewController *storiesViewController = segue.destinationViewController;
        storiesViewController.title = [_titles objectAtIndex:_selectedIndex];
        
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorFromHexString:[_colors objectAtIndex:_selectedIndex]]];
        
    }
}

-(void) performSegueForStories
{
    [self performSegueWithIdentifier:@"StoriesSegue" sender:self];
}

-(void) snapGenreAsNavigationBar:(UIView *) genreView
{
    // hide the navigation bar
    [self.navigationController setNavigationBarHidden:YES];

    [_animator removeBehavior:_gravity];
    
    _snap = [[UISnapBehavior alloc] initWithItem:genreView snapToPoint:CGPointMake(self.view.center.x, genreView.frame.size.height/2)];
    _snap.damping = 1.0;
    [_animator addBehavior:_snap];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        UILabel *titleLabel = (UILabel *) [genreView viewWithTag:1];
        
        genreView.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
        titleLabel.frame = CGRectMake(0, 20, genreView.frame.size.width, 44);
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(performSegueForStories) withObject:nil afterDelay:0.2];
        
    }];
    
}

-(void) tapped:(UITapGestureRecognizer *)recognizer
{
    _selectedIndex = recognizer.view.tag;
    [self snapGenreAsNavigationBar:recognizer.view];
}

-(void) registerGestures:(UIView *) genreView
{
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [genreView addGestureRecognizer:singleTapGestureRecognizer];
}

@end
