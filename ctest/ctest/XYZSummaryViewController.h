//
//  XYZViewController.h
//  ctest
//
//  Created by Kevin Byrne on 3/22/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSMutableArray+QueueAdditions.h"

@interface XYZSummaryViewController : UIViewController

@property (nonatomic) NSMutableArray* gameSession;

//These are arrays of (NSInteger timeInMs, Boolean didWin)
@property NSMutableArray * topScore;
@property NSMutableArray * bottomScore;

- (IBAction)next:(id)sender;

@end
