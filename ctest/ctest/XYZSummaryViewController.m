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
    if ([self.gameSession count] == 0) {
        [self.nextButton setTitle:@"GAME OVER" forState:UIControlStateNormal];
        self.nextButton.enabled = NO;
    } else {
        
    }
    
    NSMutableString *top = [[NSMutableString alloc] init];
    for (NSArray* currentPair in self.topScore)
    {
        NSString *temp = [[currentPair objectAtIndex:0] stringValue];
        [top appendString:temp];
        [top appendString:@"\n"];
    }
    [self.topScoreText setText:top];
    
    NSMutableString *bottom = [[NSMutableString alloc] init];
    for (NSArray* currentPair in self.bottomScore)
    {
        NSString *temp = [[currentPair objectAtIndex:0] stringValue];
        [bottom appendString:temp];
        [bottom appendString:@"\n"];
    }
    [self.bottomScoreText setText:bottom];
    
    self.bottomScoreText.textAlignment = NSTextAlignmentCenter;
    self.topScoreText.textAlignment = NSTextAlignmentCenter;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)next:(id)sender {
//    NSLog(@"nextGame pressed");
    NSString * segue = [NSString stringWithFormat: @"to%@", [self.gameSession dequeue]];
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
