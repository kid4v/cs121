//
//  XYZColorChangeViewController.m
//  ctest
//
//  Created by CS121 on 2/19/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//
#import "XYZColorChangeViewController.h"

@interface XYZColorChangeViewController ()
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

@implementation XYZColorChangeViewController

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
	// Do any additional setup after loading the view.

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gamesStart:(id)sender {
    self.readyButton.titleLabel.text = @"set";
    if (!self.started){
        double waitTime = ((double)rand() / RAND_MAX) * 3 + 1;
        //NSLog(@"%f", waitTime);
        [NSTimer scheduledTimerWithTimeInterval:waitTime target:self
                                       selector:@selector(start:)
                                       userInfo:nil
                                        repeats:NO];
    }
    else if ([self isOver]){
        [self reset];
    }
}
- (bool) isOver{
    return (self.topTapped && self.bottomTapped);
}
- (void) reset
{
    self.bottomTapped = false;
    self.topTapped = false;
    self.started = false;
    
    self.readyButton.titleLabel.text = @"READY!";
    
    self.topTextBox.text = @"";
    self.topTimeBox.text = @"";
    self.bottomTextBox.text = @"";
    self.bottomTimeBox.text = @"";
    
    self.topView.backgroundColor = [UIColor whiteColor];
    self.bottomView.backgroundColor = [UIColor whiteColor];
}

- (IBAction) start: (id)sender {
    if(!self.started){
    self.started = true;
    self.startTime = CACurrentMediaTime();
    self.topView.backgroundColor = [UIColor greenColor];
    self.bottomView.backgroundColor = [UIColor greenColor];
    self.readyButton.titleLabel.text = @"GO!";
    }
}

- (IBAction)onBottomPressed:(id)sender {
    //prevent false updates
    if (!self.bottomTapped && self.started){
        //we won so we just set the color eventaully we will record the time too
        self.bottomTapped = true;
        self.bottomView.backgroundColor = [UIColor redColor];
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval howFast = currentTime - self.startTime;

        if (!self.topTapped){
            self.bottomTextBox.text = @"You won!";
        }
        
        else {
            self.bottomTextBox.text = @"You Lost";
            self.readyButton.titleLabel.text = @"RESET";
        }

        self.bottomTimeBox.text = [NSString stringWithFormat:@"%f",howFast];
    }
    else if (!self.started && !self.bottomTapped){
        [self missFireFrom:self.bottomTextBox and:self.topTextBox];
    }
    
}
- (IBAction)onTopPressed:(id)sender {
    
    //prevent false update
if (!self.topTapped && self.started){
    self.topTapped = true;
    CFTimeInterval currentTime = CACurrentMediaTime();
    CFTimeInterval howFast = currentTime - self.startTime ;
    self.topView.backgroundColor = [UIColor redColor];
    if (!self.bottomTapped){
        [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
        self.topTextBox.text = @"You won!";
        }
    else {
        [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
        self.topTextBox.text = @"You Lost";
        self.readyButton.titleLabel.text = @"RESET";
    }
    
    [self.topTimeBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
    self.topTimeBox.text = [NSString stringWithFormat:@"%f",howFast];
}
else if (!self.started && !self.topTapped){
    [self missFireFrom:self.topTextBox and:self.bottomTextBox];
}
}

- (IBAction)missFireFrom:(UILabel*)loser and: (UILabel*) winner
{
    self.bottomTapped = true;
    self.topTapped = true;
    self.started = true;
    self.topView.backgroundColor = [UIColor redColor];
    self.bottomView.backgroundColor = [UIColor redColor];
    [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
    winner.text = @"Other played missfired you win!";
    loser.text = @"Missfire, You lose!";
    self.readyButton.titleLabel.text = @"RESET";
}
@end
