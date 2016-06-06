//
//  TBVC_03.m
//  UIView-C04
//
//  Created by BobZhang on 16/6/6.
//  Copyright © 2016年 BobZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utility.h"

#pragma mark - TBVC_03
#import "UIView+NameExtensions.h"
@interface TBVC_03 : UIViewController
@end

@implementation TBVC_03

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

#pragma mark - TBVC_11

@interface TBVC_11 : UIViewController
@end

@implementation TBVC_11{
    UIView *bounceView;
}

- (void)enable:(BOOL)enabled{
    for (UIBarButtonItem *item in self.navigationItem.leftBarButtonItems)
        item.enabled = enabled;
    self.navigationItem.rightBarButtonItem.enabled = enabled;
}

- (void)loadView{
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
}

@end
