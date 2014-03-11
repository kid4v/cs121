//
//  XYZMenuViewController.m
//  ctest
//
//  Created by Kevin Byrne on 3/9/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "XYZMenuViewController.h"


@interface XYZMenuViewController ()

@property NSMutableArray* gameSession;

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
    NSString * preview = [[self.gameSession valueForKey:@"description"] componentsJoinedByString:@""];
    self.sessionPreview.text = preview;
}

//add a minigame #1 to the session.
- (IBAction)mini1:(id)sender {
    [self.gameSession enqueue:@1];
    [self update];
}

//Register2ViewController *destViewController = segue.destinationViewController;
//destViewController.textArraysParsed = textArrays;
//NSLog(@"destViewController Array %@", destViewController.textArraysParsed);
//}

//essentially passes the gameSession array along the segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"1"]){
        XYZMini1ViewController *destViewController = (XYZMini1ViewController *)segue.destinationViewController;
        destViewController.gameSession = self.gameSession;
    }
}

- (IBAction)startSession:(id)sender {
    if ([self.gameSession count] == 0) {
        self.sessionPreview.text = @"Add a game first!";
    } else {
        NSString * segue = [NSString stringWithFormat: @"%@", [self.gameSession dequeue]];
        [self performSegueWithIdentifier:segue sender:sender];
    }
}
@end
