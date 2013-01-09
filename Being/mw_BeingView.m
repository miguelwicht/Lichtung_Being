//
//  mw_BeingView.m
//  Being
//
//  Created by Miguel dos Santos Vaz Dias Wicht on 04.01.13.
//  Copyright (c) 2013 Miguel dos Santos Vaz Dias Wicht. All rights reserved.
//

#import "mw_BeingView.h"

@implementation mw_BeingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _length = 200;
        _pulse = 0;
        _pulseTimer = 0;
        _speed = 0.01;
        _lines = [[NSMutableArray alloc] init];
        _width = self.frame.size.width;
        
        _color = [UIColor whiteColor].CGColor;
        [self setBackgroundColor:[UIColor clearColor]];
        
        int i;
        CGFloat n = _width * 0.8; // number of lines depend on the width -> the smaller views need less lines to look good
        
        // not really used except for the count
        for (i = 0; i < n; i++)
        {
            [_lines addObject:[NSNumber numberWithFloat:(200 * (i / n))]];
        }
        
        // start timer for redrawing the view
        [NSTimer scheduledTimerWithTimeInterval:_speed target:self selector:@selector(redraw) userInfo:nil repeats:NO];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    _pulseTimer += M_PI / 2;
    _pulse += 0.01;
    _length -= 1;
    
    CGFloat x;
    int i;
    CGFloat i2;
    CGFloat n = [_lines count];
    CGFloat v;
    
    CGContextRef context = UIGraphicsGetCurrentContext();   // reset context everytime view gets drawn
    context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, _color);
    CGContextSetLineWidth(context, 0.7);
    
    for (i = 0; i < n; i++) {
        i2 = i;
        v = i2 / n;
        v+= _pulse;
        x = fabsf(sinf(M_PI * 1.2 * v) * _width / 2.857142857);
        
        CGContextMoveToPoint(context, _width / 2,0); //start at this point
        CGContextAddLineToPoint(context, 1 + x + _width / 2, 30 + (_width - 30) * (i / n)); //draw to this point
    }
    
    for (i = 0; i < n; i++) {
        v = i / n;
        v+= _pulse;
        x = fabsf(sinf(M_PI * 1.2 * v) * _width / 2.857142857);
        
        CGContextMoveToPoint(context, _width / 2,0); //start at this point
        CGContextAddLineToPoint(context, -1 - x + _width / 2, 30 + (_width - 30)  * (i / n)); //draw to this point
    }
    
    CGContextStrokePath(context);
}

- (void)redraw {
/*  trying to add some timing to the animation
 
    _speed += 0.001;
    NSLog(@"%f",_speed);
    CGFloat _sinSpeed = ((fabs(sinf(100*_speed)) +1)*0.018);
    NSLog(@"%f",_sinSpeed);
*/
    [NSTimer scheduledTimerWithTimeInterval:_speed target:self selector:@selector(redraw) userInfo:nil repeats:NO];
    
    [self setNeedsDisplay];
}


@end
