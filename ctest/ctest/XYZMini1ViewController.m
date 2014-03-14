//
//  XYZColorChangeViewController.m
//  ctest
//
//  Created by CS121 on 2/19/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//
#import "XYZMini1ViewController.h"

@interface XYZMini1ViewController ()
@property Boolean started;
@property (weak, nonatomic) IBOutlet XYZColorUIView *topView;
@property (weak, nonatomic) IBOutlet XYZColorUIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *topTextBox;
@property (weak, nonatomic) IBOutlet UILabel *bottomTextBox;
@property (weak, nonatomic) IBOutlet UILabel *topTimeBox;
@property (weak, nonatomic) IBOutlet UILabel *bottomTimeBox;
@property (weak, nonatomic) IBOutlet UIButton *readyButton;
@property Boolean topTapped;
@property Boolean bottomTapped;
@property CFTimeInterval startTime;


@end

@implementation XYZMini1ViewController

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
    [self setup];
	// Do any additional setup after loading the view.

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gamesStart:(id)sender {
    if (!self.started){
        [self.readyButton setTitle:@"SET..." forState:UIControlStateNormal];
//        NSLog(@"%@", self.readyButton.titleLabel.text);
        self.readyButton.enabled = NO;
        double waitTime = ((double)rand() / RAND_MAX) * 3 + 1;
        //NSLog(@"%f", waitTime);
        [NSTimer scheduledTimerWithTimeInterval:waitTime target:self
                                       selector:@selector(start:)
                                       userInfo:nil
                                        repeats:NO];
    }
    //If this game is over...
    else if ([self isOver]){
        //check for more games in gameSession
        if ([self.gameSession count] == 0) {
            [self.readyButton setTitle:@"GAME OVER" forState:UIControlStateNormal];
            self.readyButton.enabled = NO;
        } else {
            NSString * segue = [NSString stringWithFormat: @"%@", [self.gameSession dequeue]];
            //if next game is also 1, use self1 segue.
            if ([segue isEqualToString:@"1"]){
                segue = [NSString stringWithFormat:@"self%@", segue];
            }
            [self performSegueWithIdentifier:segue sender:sender];
        }
    }
}
- (bool) isOver{
    return (self.topTapped && self.bottomTapped);
}
- (void) setup
{
    self.bottomTapped = false;
    self.topTapped = false;
    self.started = false;
    
    [self.readyButton setTitle:@"READY?" forState:UIControlStateNormal];
    self.readyButton.enabled = YES;
    
    self.topTextBox.text = @"";
    self.topTimeBox.text = @"";
    self.bottomTextBox.text = @"";
    self.bottomTimeBox.text = @"";
    
    self.topView.backgroundColor = UIColorFromRGB(0x34495e);
    self.bottomView.backgroundColor = UIColorFromRGB(0x34495e);
}

// GO!!!
- (IBAction) start: (id)sender {
    if(!self.started){
    self.started = true;
    self.startTime = CACurrentMediaTime();
    self.topView.backgroundColor = UIColorFromRGB(0x34495e);
    self.bottomView.backgroundColor = UIColorFromRGB(0x34495e);
        [self.readyButton setTitle:@"GO!!!" forState:UIControlStateNormal];
    }
}

- (IBAction)onBottomPressed:(id)sender {
    //prevent false updates
    if (!self.bottomTapped && self.started){
        //we won so we just set the color eventaully we will record the time too
        self.bottomTapped = true;
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval elapsedTime = currentTime - self.startTime;

        //bottom wins
        if (!self.topTapped){
            self.bottomTextBox.text = @"You won!";
            self.bottomView.backgroundColor = UIColorFromRGB(0x2ecc71);
        }
        
        //top wins
        else {
            self.bottomView.backgroundColor = UIColorFromRGB(0x2ecc71);
            self.bottomTextBox.text = @"You Lost";
            [self.readyButton setTitle:@"NEXT" forState:UIControlStateNormal];
            self.readyButton.enabled = YES;
        }

        self.bottomTimeBox.text = [NSString stringWithFormat:@"%f",elapsedTime];
    }
    else if (!self.started && !self.bottomTapped){
        [self misFireFrom:self.bottomTextBox and:self.topTextBox];
    }
    
}
- (IBAction)onTopPressed:(id)sender {
    
    //prevent false update
if (!self.topTapped && self.started){
    self.topTapped = true;
    CFTimeInterval currentTime = CACurrentMediaTime();
    CFTimeInterval howFast = currentTime - self.startTime ;
    
    //top wins
    if (!self.bottomTapped){
        self.topView.backgroundColor = [UIColor greenColor];
        [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
        self.topTextBox.text = @"You won!";
        }
    //bottom wins
    else {
        self.topView.backgroundColor = [UIColor redColor];
        [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
        self.topTextBox.text = @"You Lost";
        [self.readyButton setTitle:@"NEXT" forState:UIControlStateNormal];
        self.readyButton.enabled = YES;
    }
    
    [self.topTimeBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
    self.topTimeBox.text = [NSString stringWithFormat:@"%f",howFast];
}
else if (!self.started && !self.topTapped){
    [self misFireFrom:self.topTextBox and:self.bottomTextBox];
}
}

- (IBAction)misFireFrom:(UILabel*)loser and: (UILabel*) winner
{
    self.bottomTapped = true;
    self.topTapped = true;
    self.started = true;
    self.topView.backgroundColor = [UIColor redColor];
    self.bottomView.backgroundColor = [UIColor redColor];
    [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
    winner.text = @"Other played misfired you win!";
    loser.text = @"Misfire, You lose!";
    [self.readyButton setTitle:@"NEXT" forState:UIControlStateNormal];
    self.readyButton.enabled = YES;
}
@end
