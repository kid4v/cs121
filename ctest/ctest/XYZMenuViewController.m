//
//  XYZMenuViewController.m
//  ctest
//
//  Created by Kevin Byrne on 3/9/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "XYZMenuViewController.h"
#import "XYZSummaryViewController.h"


@interface XYZMenuViewController ()

@property NSMutableArray* gameSession;
@property NSMutableArray* topScore;
@property NSMutableArray* bottomScore;

@end

@implementation XYZMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reset];
    self.gameSession = [[NSMutableArray alloc] init];
    self.bottomScore = [[NSMutableArray alloc] init];
    self.topScore = [[NSMutableArray alloc] init];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reset {
    [self.gameSession removeAllObjects];
}

//updates the display that previews the game session to be played.
- (void) update {
    //space out array into string
    NSString * preview = [[self.gameSession valueForKey:@"description"] componentsJoinedByString:@" "];
    self.sessionPreview.text = preview;
}

//add a minigame #1 to the session.
- (IBAction)mini1:(id)sender {
    if ([self.gameSession count] < 10) {
        [self.gameSession enqueue:@1];
        [self update];
    }
    else {
        [self.sessionPreview setTextColor:[UIColor redColor]];
        [self performSelector:@selector(resetColor) withObject:nil afterDelay:.1];

    }
}

- (void) resetColor {
    [self.sessionPreview setTextColor:[UIColor blackColor]];
}

//passes the gameSession array along the segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    XYZSummaryViewController *destViewController = (XYZSummaryViewController *)segue.destinationViewController;
    destViewController.gameSession = self.gameSession;
    destViewController.topScore = self.topScore;
    destViewController.bottomScore = self.bottomScore;
}

- (IBAction)startSession:(id)sender {
    if ([self.gameSession count] == 0) {
        self.sessionPreview.text = @"Add a game first!";
    } else {
        NSString * segue = [NSString stringWithFormat: @"start%@", [self.gameSession dequeue]];
        [self performSegueWithIdentifier:segue sender:sender];
    }
}
@end
