//
//  XYZViewController.m
//  ctest
//
//  Created by Kevin Byrne on 3/22/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "XYZSummaryViewController.h"
#import "NSMutableArray+QueueAdditions.h"

@interface XYZSummaryViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation XYZSummaryViewController

NSArray *tableData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSInteger topSum = 0;
    NSInteger bottomSum = 0;
    
    NSMutableString *top = [[NSMutableString alloc] init];
    for (NSArray* currentPair in self.topScore)
    {
        topSum += [[currentPair objectAtIndex:0] intValue];
        
        NSString *temp = [[currentPair objectAtIndex:0] stringValue];
        [top appendString:temp];
        [top appendString:@"\n"];
    }
    
    NSMutableString *bottom = [[NSMutableString alloc] init];
    for (NSArray* currentPair in self.bottomScore)
    {
        bottomSum += [[currentPair objectAtIndex:0] intValue];
        
        NSString *temp = [[currentPair objectAtIndex:0] stringValue];
        [bottom appendString:temp];
        [bottom appendString:@"\n"];
    }
    
    
    if ([self.gameSession count] == 0) {
        [self.nextButton setTitle:@"Start Over?" forState:UIControlStateNormal];
        
        //Add the final scores
        [top appendString:@"---------\n"];
        [bottom appendString:@"---------\n"];
        [top appendString:[NSString stringWithFormat: @"%d", topSum]];
        [bottom appendString:[NSString stringWithFormat: @"%d", bottomSum]];
        
        //Declare winner
        if (topSum < bottomSum) {
            [self.winnerLabel setText:@"Top Wins!"];
        } else if (bottomSum < topSum) {
            [self.winnerLabel setText:@"Bottom Wins!"];
        } else {
            [self.winnerLabel setText:@"Tie Game!"];
        }
    }
    
    //update score text
    [self.topScoreText setText:top];
    [self.bottomScoreText setText:bottom];
    //center score text
    self.bottomScoreText.textAlignment = NSTextAlignmentCenter;
    self.topScoreText.textAlignment = NSTextAlignmentCenter;

}

- (void) sumScores:(NSMutableArray*)scoreArray into:(UITextView*)text {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)next:(id)sender {
    //if game session is done then restart, otherwise go to next game.
    NSString * segue;
    if ([self.gameSession count] == 0) {
        segue = @"restart";
    }else {
        segue = [NSString stringWithFormat: @"to%@", [self.gameSession dequeue]];

    }
    [self performSegueWithIdentifier:segue sender:sender];
}

#pragma mark - Navigation

//passes the gameSession array along the segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    XYZSummaryViewController *destViewController = (XYZSummaryViewController *)segue.destinationViewController;
    destViewController.gameSession = self.gameSession;
    destViewController.topScore = self.topScore;
    destViewController.bottomScore = self.bottomScore;
}

@end
