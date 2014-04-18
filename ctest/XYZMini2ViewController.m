//
//  XYZMini2ViewController.m
//  ctest
//
//  Created by Billy Mills on 4/14/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "XYZMini2ViewController.h"

@interface XYZMini2ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (weak, nonatomic) IBOutlet UIButton *readyButton;
@property (weak, nonatomic) IBOutlet UIButton *lowerLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *upperLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *lowerRightButton;
@property (weak, nonatomic) IBOutlet UIButton *upperRightButton;
@property CFTimeInterval startTime;
@property int gameCase;
@property Boolean started;
@property Boolean lowerLeftTapped;
@property Boolean lowerRightTapped;
@property Boolean upperLeftTapped;
@property Boolean upperRightTapped;
@end



@implementation XYZMini2ViewController

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
    // Do any additional setup after loading the view.
	self.gameCase = arc4random()%4; //random number to choose which stimuli player will receive
	[self.lowerLeftButton setBackgroundColor:UIColorFromRGB(0xc0392b)];
	[self.upperLeftButton setBackgroundColor:UIColorFromRGB(0xc0392b)];
	[self.lowerRightButton setBackgroundColor:UIColorFromRGB(0x3498db)];
	[self.upperRightButton setBackgroundColor:UIColorFromRGB(0x3498db)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Game Initialization... giving the players the stimuli they need to choose the right button
- (IBAction)readyButtonPressed:(id)sender {
	if (!self.started){
        [self.readyButton setBackgroundColor:UIColorFromRGB(0xFFDB4D)];
        self.readyButton.enabled = NO;
        double waitTime = ((double)rand() / RAND_MAX) * 5 + 1;
        [NSTimer scheduledTimerWithTimeInterval:waitTime target:self
                                       selector:@selector(start)
                                       userInfo:nil
                                        repeats:NO];
    }
}

- (void) start {
    if(!self.started){
        self.started = true;
        self.startTime = CACurrentMediaTime();
        [self.readyButton setBackgroundColor:UIColorFromRGB(0x2ecc71)];
		//give player different stimuli based on a random number
		if (self.gameCase == 0) {
			[self startWithBlueTextRedColor];
		}
		if (self.gameCase == 1) {
			[self startWithBlueTextBlueColor];
		}
		if (self.gameCase == 2) {
			[self startWithRedTextRedColor];
		}
		if (self.gameCase == 3) {
			[self startWithRedTextBlueColor];
		}
    }
}
//the different options for starting game
-(void) startWithBlueTextRedColor
{
	[self.bottomButton setTitle:@"Blue" forState:(UIControlStateNormal)];
	[self.topButton setTitle:@"Blue" forState:(UIControlStateNormal)];
	[self.bottomButton setTitleColor:(UIColorFromRGB(0xc0392b)) forState:(UIControlStateNormal)];
	[self.topButton setTitleColor:(UIColorFromRGB(0xc0392b)) forState:(UIControlStateNormal)];
}
-(void) startWithBlueTextBlueColor
{
	[self.bottomButton setTitle:@"Blue" forState:(UIControlStateNormal)];
	[self.topButton setTitle:@"Blue" forState:(UIControlStateNormal)];
	[self.bottomButton setTitleColor:(UIColorFromRGB(0x3498db)) forState:(UIControlStateNormal)];
	[self.topButton setTitleColor:(UIColorFromRGB(0x3498db)) forState:(UIControlStateNormal)];
}
-(void) startWithRedTextRedColor
{
	[self.bottomButton setTitle:@"Red" forState:(UIControlStateNormal)];
	[self.topButton setTitle:@"Red" forState:(UIControlStateNormal)];
	[self.bottomButton setTitleColor:(UIColorFromRGB(0xc0392b)) forState:(UIControlStateNormal)];
	[self.topButton setTitleColor:(UIColorFromRGB(0xc0392b)) forState:(UIControlStateNormal)];
}
-(void) startWithRedTextBlueColor
{
	[self.bottomButton setTitle:@"Red" forState:(UIControlStateNormal)];
	[self.topButton setTitle:@"Red" forState:(UIControlStateNormal)];
	[self.bottomButton setTitleColor:(UIColorFromRGB(0x3498db)) forState:(UIControlStateNormal)];
	[self.topButton setTitleColor:(UIColorFromRGB(0x3498db)) forState:(UIControlStateNormal)];
}


//Player Reactions... dealing with actions after the game has been set into action
- (IBAction)lowerLeftButtonPressed:(id)sender {
}

- (IBAction)upperLeftButtonPressed:(id)sender {
}

- (IBAction)lowerRightButtonPressed:(id)sender {
}

- (IBAction)upperRightButtonPressed:(id)sender {
}

- (IBAction)lowerRightButtonPresseed:(id)sender {
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
