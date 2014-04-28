//
//  XYZMenuViewController.h
//  ctest
//
//  Created by Kevin Byrne on 3/9/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

//test

#import <UIKit/UIKit.h>
#import "XYZMini1ViewController.h"
#import "NSMutableArray+QueueAdditions.h"

@interface XYZMenuViewController : UIViewController
- (IBAction)mini1:(id)sender;
- (IBAction)mini2:(id)sender;
- (IBAction)mini3:(id)sender;

- (IBAction)startSession:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *sessionPreview;

@end
