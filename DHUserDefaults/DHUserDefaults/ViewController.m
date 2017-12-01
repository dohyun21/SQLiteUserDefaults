//
//  ViewController.m
//  DHUserDefaults
//
//  Created by kdh on 2017. 12. 1..
//  Copyright © 2017년 Kim Do Hyun. All rights reserved.
//

#import "ViewController.h"
#import "DHUserDefaults.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[DHUserDefaults sharedInstance] setObject:@"bar" key:@"foo"];
    NSLog(@"%@", [[DHUserDefaults sharedInstance] getObjectWithKey:@"foo"]);
    
    [[DHUserDefaults sharedInstance] setObject:@(31) key:@"int"];
    NSLog(@"%@", [[DHUserDefaults sharedInstance] getObjectWithKey:@"int"]);
    
    [[DHUserDefaults sharedInstance] setObject:@(535.3463) key:@"float"];
    NSLog(@"%@", [[DHUserDefaults sharedInstance] getObjectWithKey:@"float"]);
    
    [[DHUserDefaults sharedInstance] setObject:[NSDate date] key:@"date"];
    NSLog(@"%@", [[DHUserDefaults sharedInstance] getObjectWithKey:@"date"]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
