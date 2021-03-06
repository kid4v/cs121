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

//These are arrays of (NSInteger timeInMs, Boolean didWin) tuples.
@property NSMutableArray * topScore;
@property NSMutableArray * bottomScore;

@property (weak, nonatomic) IBOutlet UITextView *topScoreText;
@property (weak, nonatomic) IBOutlet UITextView *bottomScoreText;
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;

- (IBAction)next:(id)sender;

@end
