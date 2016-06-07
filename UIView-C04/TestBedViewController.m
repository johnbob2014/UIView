//
//  TBVC_03_NameExtensions.m
//  UIView-C04
//
//  Created by BobZhang on 16/6/6.
//  Copyright © 2016年 BobZhang. All rights reserved.
//


#import "TestBedViewController.h"
#import "Utility.h"
#import "GeneralMethod.h"

#pragma mark - TBVC_03_NameExtensions
#import "UIView+NameExtensions.h"

@implementation TBVC_03_NameExtensions

- (void) action:(id)sender
{
    UISwitch *aSwitch = (UISwitch *) [self.view viewNamed:@"topSwitch"];
    aSwitch.on = !aSwitch.isOn;
    
    ((UILabel *)[self.view viewNamed:@"infoLabel"]).text = [NSString stringWithFormat:@"The switch is %@", aSwitch.isOn ? @"on" : @"off"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self addSomeViewByNameTag];
    
    ((UILabel *)[self.view viewNamed:@"infoLabel"]).text = @"The switch is on";
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"Action", @selector(action:));
    
    NSMutableString *infoString=[[NSMutableString alloc]init];
    [self.view dumpViewAtIndent:0 intoMutalbeString:infoString];
    NSLog(@"\n%@",infoString);
}

- (void)addSomeViewByNameTag{
    UISwitch *aSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(100, 100, 60, 60)];
    aSwitch.nameTag=@"topSwitch";
    [self.view addSubview:aSwitch];
    
    UILabel *aLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 200, 160, 60)];
    aLabel.nameTag=@"infoLabel";
    [self.view addSubview:aLabel];
}

@end

#pragma mark - TBVC_09
@import QuartzCore;

@implementation TBVC_09_CoreAnimation{
    UIImageView *frontIV;
    UIImageView *backIV;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:[@"Fade Over Push Reveal" componentsSeparatedByString:@" "]];
    sc.selectedSegmentIndex = 0;
    self.navigationItem.titleView = sc;
    
    backIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Maroon"]];
    [self.view addSubview:backIV];
    backIV.translatesAutoresizingMaskIntoConstraints = NO;
    CENTER_VIEW_V(self.view, backIV);
    ALIGN_VIEW_LEFT(self.view, backIV);
    
    frontIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Purple"]];
    [self.view addSubview:frontIV];
    frontIV.translatesAutoresizingMaskIntoConstraints = NO;
    CENTER_VIEW_V(self.view, frontIV);
    ALIGN_VIEW_RIGHT(self.view, frontIV);
    
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"Go", @selector(animate:));
}

- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)animate:(id)sender{
    CATransition *transition = [CATransition animation];
    transition.delegate = self;
    transition.duration = 1.0f;
    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    
    switch ([(UISegmentedControl *)self.navigationItem.titleView selectedSegmentIndex]) {
        case 0:
            transition.type = kCATransitionFade;
            break;
        case 1:
            transition.type = kCATransitionMoveIn;
            break;
        case 2:
            transition.type = kCATransitionPush;
            break;
        case 3:
            transition.type = kCATransitionReveal;
            break;
        default:
            break;
    }
    
    transition.subtype = kCATransitionFromBottom;
    
    //[self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [self.view setBackgroundColor:[GM randomUIColor]];
    [self.view.layer addAnimation:transition forKey:@"key"];
}
@end

#pragma mark - TBVC_11

@implementation TBVC_11_KeyframeAnimations{
    UIView *bounceView;
}

- (void)enable:(BOOL)enabled{
    for (UIBarButtonItem *item in self.navigationItem.leftBarButtonItems)
        item.enabled = enabled;
    self.navigationItem.rightBarButtonItem.enabled = enabled;
}

- (void)loadView{
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor grayColor];
    
    bounceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    bounceView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bounceView];
    bounceView.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
    
    self.navigationItem.leftBarButtonItems = @[BARBUTTON(@"Zoom", @selector(actionZoom)),BARBUTTON(@"Move", @selector(actionMove))];
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"Show", @selector(bounce));
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    bounceView.center = RECTCENTER(self.view.bounds);
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
              withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    bounceView.center = RECTCENTER(self.view.bounds);
}

- (void)bounce{
    [self enable:NO];
    bounceView.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
    bounceView.center = RECTCENTER(self.view.bounds);
    
    //定义关键帧，放入块中备用（此处也可以不用块，直接在执行关键帧动画时定义。但是这样代码更为清晰易懂。）
    void(^keyframesAnimations)() = ^() {
        [UIView addKeyframeWithRelativeStartTime:0.0
                                relativeDuration:0.5
                                      animations:^{
                                          bounceView.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5
                                relativeDuration:0.5
                                      animations:^{
                                          bounceView.transform = CGAffineTransformIdentity;
        }];
    };
    
    //执行关键帧动画，传入关键帧块
    [UIView animateKeyframesWithDuration:0.6
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:keyframesAnimations
                              completion:^(BOOL finished) {
                                  [self enable:YES];
                              }];
}

- (void)actionZoom{
    CGFloat midX = CGRectGetMidX(self.view.bounds);
    CGFloat midY = CGRectGetMidY(self.view.bounds);
    CGAffineTransform transientTransform = CGAffineTransformMakeScale(1.2f, 1.2f);
    CGAffineTransform shrinkTransform = CGAffineTransformMakeScale(0.001f, 0.001f);
    
    [self enable:NO];
    bounceView.center = CGPointMake(midX, midY);
    bounceView.transform = shrinkTransform;
    
    void(^keyframesAnimations)() = ^(){
        [UIView addKeyframeWithRelativeStartTime:0.0
                                relativeDuration:0.5 animations:^{
                                    bounceView.transform = transientTransform;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5
                                relativeDuration:0.5
                                      animations:^{
                                    bounceView.transform = CGAffineTransformIdentity;
        }];
    };
    
    //嵌套关键帧动画！语法比较复杂
    // I had this as one animation block originally using calculated durations and start times.
    // Apparently, the long (2 second) delay between the bounce in and bounce out seem to make
    // things go wonky.  Breaking them up in two animations with a delay solved things.
    [UIView animateKeyframesWithDuration:0.6
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:keyframesAnimations
                              completion:^(BOOL finished) {
                                  [UIView animateKeyframesWithDuration:0.6
                                                                 delay:2.0
                                                               options:UIViewKeyframeAnimationOptionCalculationModeCubic
                                                            animations:keyframesAnimations
                                                            completion:^(BOOL finished) {
                                                                [self enable:YES];
                                                            }];
                              }];
    
    
}

- (void)actionMove
{
    CGFloat midX = CGRectGetMidX(self.view.bounds);
    CGFloat midY = CGRectGetMidY(self.view.bounds);
    CGPoint centerPoint = CGPointMake(midX, midY);
    CGPoint beyondPoint = CGPointMake(midX * 1.2f, midY);
    CGPoint offScreenPoint = CGPointMake(-midX, midY);
    
    [self enable:NO];
    bounceView.center = CGPointMake(-midX, midY);
    bounceView.transform = CGAffineTransformIdentity;
    
    void(^keyframesAnimationsOne)() = ^() {
        [UIView addKeyframeWithRelativeStartTime:0.0
                                relativeDuration:0.5
                                      animations:^{
                                          bounceView.center = beyondPoint;
                                      }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5
                                relativeDuration:0.5
                                      animations:^{
                                          bounceView.center = centerPoint;
                                      }];
    };
    
    void(^keyframesAnimationsTwo)() = ^() {
        [UIView addKeyframeWithRelativeStartTime:0.0
                                relativeDuration:0.5
                                      animations:^{
                                          bounceView.center = beyondPoint;
                                      }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5
                                relativeDuration:0.5
                                      animations:^{
                                          bounceView.center = offScreenPoint;
                                      }];
    };
    
    //嵌套关键帧动画！语法比较复杂
    // Again, had this in one key frame block originally.  In addition to the timing issues,
    // discovered an odd bug in the cubic mode calculations that caused a strange floating issue.
    // Linear mode solved the issue but made for a very stiff / jarring bounce.
    // Breaking into two separate animations solved the issues.
    [UIView animateKeyframesWithDuration:0.6
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:keyframesAnimationsOne
                              completion:^(BOOL finished) {
                                  [UIView animateKeyframesWithDuration:0.6
                                                                 delay:2
                                                               options:UIViewKeyframeAnimationOptionCalculationModeCubic
                                                            animations:keyframesAnimationsTwo                                                            completion:^(BOOL finished) {
                                                                [self enable:YES];
                                                            }
                                   ];
                              }
     ];
}

@end
