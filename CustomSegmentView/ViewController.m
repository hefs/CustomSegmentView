//
//  ViewController.m
//  CustomSegmentView
//
//  Created by 何发松 on 2017/9/5.
//  Copyright © 2017年 HeRay. All rights reserved.
//

#import "ViewController.h"
#import "CustomSegment.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CustomSegment *segment = [[CustomSegment alloc] initWithFrame:CGRectMake(0, 30, MAINSCREENWIDTH, 40)];
    segment.space = 1;
    segment.align = SegmentLayoutAlignHorizontal;
    [segment addSegmentWithTitle:@"Title1" hanlder:^(NSString *title) {
        NSLog(@"%@",title);
    }];
    [segment addSegmentWithTitle:@"Title2" hanlder:^(NSString *title) {
        NSLog(@"%@",title);
    }];
    [segment addSegmentWithTitle:@"Title3" hanlder:^(NSString *title) {
        NSLog(@"%@",title);
    }];
    segment.selectedIndex = 1;
    [self.view addSubview:segment];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
