//
//  XYZColorChangeViewController.h
//  ctest
//
//  Created by CS121 on 2/19/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZColorUIView.h"
#import "NSMutableArray+QueueAdditions.h"

@interface XYZMini1ViewController : UIViewController

- (IBAction)onBottomPressed:(id)sender;
- (IBAction)onTopPressed:(id)sender;
- (IBAction)gamesStart:(id)sender;

@property (nonatomic) NSMutableArray* gameSession;

@end
