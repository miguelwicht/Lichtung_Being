//
//  mw_BeingViewController.h
//  Being
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 04.01.13.
//  Copyright (c) 2013 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mw_BeingView.h"

@interface mw_BeingViewController : UIViewController {
    mw_BeingView *being;
    mw_BeingView *being2;
    mw_BeingView *being3;
}

- (void)animate:(UIView *)view To:(CGPoint)endPoint;
@end
