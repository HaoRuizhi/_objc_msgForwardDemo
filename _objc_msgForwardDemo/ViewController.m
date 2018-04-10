//
//  ViewController.m
//  _objc_msgForwardDemo
//
//  Created by haorise on 2018/4/10.
//  Copyright © 2018年 haorise. All rights reserved.
//

#import "ViewController.h"
#import "ChildClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ChildClass *child = [[ChildClass alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
