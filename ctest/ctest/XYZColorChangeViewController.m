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
@property Boolean topTaped;
@property Boolean bottomTapped;
@property CFTimeInterval startTime;


@end

@implementation XYZColorChangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.bottomTapped = false;
        self.topTaped = false;
        self.started = false;

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.topView.backgroundColor = [UIColor yellowColor];
    self.bottomView.backgroundColor = [UIColor yellowColor];

	// Do any additional setup after loading the view.

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gamesStart:(id)sender {

    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self
        selector:@selector(start:)
        userInfo:nil
        repeats:NO];
}

- (IBAction) start: (id)sender {
    self.started = true;
    self.startTime = CACurrentMediaTime();
    self.topView.backgroundColor = [UIColor greenColor];
    self.bottomView.backgroundColor = [UIColor greenColor];
    self.readyButton.titleLabel.text = @"GO!";
}

- (IBAction)onBottomPressed:(id)sender {
    //prevent false updates
    if (!self.bottomTapped && self.started){
        //we won so we just set the color eventaully we will record the time too
        self.bottomTapped = true;
        self.bottomView.backgroundColor = [UIColor redColor];
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval howFast = currentTime - self.startTime;

        if (!self.topTaped){
            self.bottomTextBox.text = @"You won!";

        }
        else {
            self.bottomTextBox.text = @"You Lost";
        }

        self.bottomTimeBox.text = [NSString stringWithFormat:@"%f",howFast];
    }
    else if (!self.started && !self.bottomTapped){
        self.bottomTapped = true;
        self.topTaped = true;
        self.topView.backgroundColor = [UIColor redColor];
        self.bottomView.backgroundColor = [UIColor redColor];
        [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
        self.topTextBox.text = @"Other played missfired you win!";
        self.bottomTextBox.text = @"Missfire, You lose!";

    }
    
}
- (IBAction)onTopPressed:(id)sender {
    
    //prevent false update
if (!self.topTaped && self.started){
    self.topTaped = true;
    CFTimeInterval currentTime = CACurrentMediaTime();
    CFTimeInterval howFast = currentTime - self.startTime ;
    if (!self.bottomTapped){
        self.topView.backgroundColor = [UIColor redColor];
        [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
        self.topTextBox.text = @"You won!";
        }
    
    else {
        self.topView.backgroundColor = [UIColor redColor];
        [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
        self.topTextBox.text = @"You Lost";
    }
    
    [self.topTimeBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
    self.topTimeBox.text = [NSString stringWithFormat:@"%f",howFast];
}
else if (!self.started && !self.topTaped){
    self.bottomTapped = true;
    self.topTaped = true;
    self.topView.backgroundColor = [UIColor redColor];
    self.bottomView.backgroundColor = [UIColor redColor];
    [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
    self.bottomTextBox.text = @"Other played missfired you win!";
    self.topTextBox.text = @"Missfire, You lose!";
    
}
}
@end
