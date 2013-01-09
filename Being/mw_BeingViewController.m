//
//  mw_BeingViewController.m
//  Being
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 04.01.13.
//  Copyright (c) 2013 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "mw_BeingViewController.h"
#import "mw_BeingView.h"
#import <QuartzCore/QuartzCore.h>
#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
#include <stdlib.h>

@interface mw_BeingViewController ()

@end

@implementation mw_BeingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor blackColor]];
        
        being = [[mw_BeingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [self.view addSubview:being];
        
        CGAffineTransform rotateRight = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(90.0));
        [being setTransform:rotateRight];
        
        // TODO: create array to save multiple beings and avoid having to name them while still be able to reference them
        being2 = [[mw_BeingView alloc] initWithFrame:CGRectMake(0, 150, 150, 150)];
        [self.view addSubview:being2];
        being2.color = [UIColor yellowColor].CGColor;
        [being2 setTransform:rotateRight];
        
        
        being3 = [[mw_BeingView alloc] initWithFrame:CGRectMake(0, 300, 200, 200)];
        [self.view addSubview:being3];
        being.color = [UIColor greenColor].CGColor;
        [being3 setTransform:rotateRight];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - animate on paths

- (void)animate:(UIView *)view To:(CGPoint)endPoint
{
    UIBezierPath *aPath = [[UIBezierPath alloc] init];
    CGPoint startPoint = CGPointMake(view.frame.origin.x, view.frame.origin.y);
    
    [aPath moveToPoint:startPoint];
    
    // curve with random control point
    [aPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(arc4random_uniform(1024), arc4random_uniform(768))];
    
    // define animation properties
    CAKeyframeAnimation *moveAlongPath = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [moveAlongPath setPath:[aPath CGPath]];
    
    // TODO: calculate duration
    double distance = sqrt(pow((startPoint.x - endPoint.x),2) + pow((startPoint.y - endPoint.y),2));
    double speed = distance / 150;
    
    [moveAlongPath setDuration:speed];
    [moveAlongPath setRotationMode:kCAAnimationRotateAuto];
    moveAlongPath.fillMode = kCAFillModeForwards;
    //    moveAlongPath.removedOnCompletion = NO;
    moveAlongPath.calculationMode = kCAAnimationPaced;
    [[view layer] addAnimation:moveAlongPath forKey:@"moveBeingAlongPath"];
    
    [view setCenter:endPoint];
}


#pragma mark - touch stuff
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // FIXME: touch while animation has not yet finished, makes beings "jump"
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    [self animate:being To:location];
    [self animate:being2 To:CGPointMake(arc4random_uniform(1024), arc4random_uniform(768))];
    [self animate:being3 To:CGPointMake(arc4random_uniform(1024), arc4random_uniform(768))];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
