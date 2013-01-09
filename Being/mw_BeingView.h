//
//  mw_BeingView.h
//  Being
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 04.01.13.
//  Copyright (c) 2013 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mw_BeingView : UIView {
    NSMutableArray *_lines;
    CGFloat _pulse;
    int _pulseTimer;
    int _length;
    int _width;
}

@property (nonatomic) CGColorRef color;
@property (nonatomic) CGFloat speed;
@end
