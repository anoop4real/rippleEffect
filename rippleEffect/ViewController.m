//
//  ViewController.m
//  rippleEffect
//
//  Created by anoopm on 05/06/15.
//  Copyright (c) 2015 anoopm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self animateImage];
}
-(void) animateImage
{
    [self addRippleEffectToView:imageView];
}

-(IBAction)animateButton:(id)sender
{
    [self addRippleEffectToView:(UIButton*) sender];
}

-(void) addRippleEffectToView:(UIView*) referenceView

{
    /*! Creates a circular path around the view*/
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, referenceView.bounds.size.width, referenceView.bounds.size.height)];
    
    /*! Position where the shape layer should be */
    CGPoint shapePosition = CGPointMake(referenceView.bounds.size.width/2.0f, referenceView.bounds.size.height/2.0f);
    
    CAShapeLayer *rippleShape = [CAShapeLayer layer];
    rippleShape.bounds = CGRectMake(0, 0, referenceView.bounds.size.width, referenceView.bounds.size.height);
    rippleShape.path = path.CGPath;
    rippleShape.fillColor = [UIColor clearColor].CGColor;
    rippleShape.strokeColor = [UIColor yellowColor].CGColor;
    rippleShape.lineWidth = 4;
    rippleShape.position = shapePosition;
    rippleShape.opacity = 0;
    
    /*! Add the ripple layer as the sublayer of the reference view */
    [referenceView.layer addSublayer:rippleShape];
    
    /*! Create scale animation of the ripples */
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2, 2, 1)];
    
    /*! Create animation for opacity of the ripples */
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = [NSNumber numberWithInt:1];
    opacityAnim.toValue = [NSNumber numberWithInt:0];;
    
    /*! Group the opacity and scale animations */
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnim, opacityAnim];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.duration = 0.7f;
    animation.repeatCount = 25;
    animation.removedOnCompletion = YES;
    
    [rippleShape addAnimation:animation forKey:@"rippleEffect"];
}
- (void) removeAllSublayersFromView:(UIView*) refView
{
    refView.layer.sublayers = nil;
}
@end
