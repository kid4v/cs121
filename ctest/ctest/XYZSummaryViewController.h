//
//  XYZViewController.h
//  ctest
//
//  Created by Kevin Byrne on 3/22/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZSummaryViewController : UIViewController

@property (nonatomic) NSMutableArray* gameSession;

@property NSInteger topScore;
@property NSInteger bottomScore;

- (IBAction)next:(id)sender;

@end
