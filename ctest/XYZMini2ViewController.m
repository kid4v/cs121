//
//  XYZMini2ViewController.m
//  ctest
//
//  Created by Billy Mills on 4/14/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "XYZMini2ViewController.h"
#import "XYZSummaryViewController.h"

@interface XYZMini2ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (weak, nonatomic) IBOutlet UIButton *readyButton;
@property (weak, nonatomic) IBOutlet UIButton *lowerLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *upperLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *lowerRightButton;
@property (weak, nonatomic) IBOutlet UIButton *upperRightButton;
@property (weak, nonatomic) IBOutlet UILabel *bottomMisfireText;
@property (weak, nonatomic) IBOutlet UILabel *topMisfireText;
@property (weak, nonatomic) IBOutlet UILabel *bottomTimeText;
@property (weak, nonatomic) IBOutlet UILabel *topTimeText;
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
	[self.upperRightButton setBackgroundColor:UIColorFromRGB(0xc0392b)];
	[self.lowerRightButton setBackgroundColor:UIColorFromRGB(0x3498db)];
	[self.upperLeftButton setBackgroundColor:UIColorFromRGB(0x3498db)];
	self.bottomMisfireText.userInteractionEnabled = NO;
	self.topMisfireText.userInteractionEnabled = NO;
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
	[self.topButton setTransform:CGAffineTransformMakeRotation(-M_PI)];
	[self.topButton setTitle:@"Blue" forState:(UIControlStateNormal)];
	[self.bottomButton setTitleColor:(UIColorFromRGB(0xc0392b)) forState:(UIControlStateNormal)];
	[self.topButton setTitleColor:(UIColorFromRGB(0xc0392b)) forState:(UIControlStateNormal)];
}
-(void) startWithBlueTextBlueColor
{
	[self.bottomButton setTitle:@"Blue" forState:(UIControlStateNormal)];
	[self.topButton setTransform:CGAffineTransformMakeRotation(-M_PI)];
	[self.topButton setTitle:@"Blue" forState:(UIControlStateNormal)];
	[self.bottomButton setTitleColor:(UIColorFromRGB(0x3498db)) forState:(UIControlStateNormal)];
	[self.topButton setTitleColor:(UIColorFromRGB(0x3498db)) forState:(UIControlStateNormal)];
}
-(void) startWithRedTextRedColor
{
	[self.bottomButton setTitle:@"Red" forState:(UIControlStateNormal)];
	[self.topButton setTransform:CGAffineTransformMakeRotation(-M_PI)];
	[self.topButton setTitle:@"Red" forState:(UIControlStateNormal)];
	[self.bottomButton setTitleColor:(UIColorFromRGB(0xc0392b)) forState:(UIControlStateNormal)];
	[self.topButton setTitleColor:(UIColorFromRGB(0xc0392b)) forState:(UIControlStateNormal)];
}
-(void) startWithRedTextBlueColor
{
	[self.bottomButton setTitle:@"Red" forState:(UIControlStateNormal)];
	[self.topButton setTransform:CGAffineTransformMakeRotation(-M_PI)];
	[self.topButton setTitle:@"Red" forState:(UIControlStateNormal)];
	[self.bottomButton setTitleColor:(UIColorFromRGB(0x3498db)) forState:(UIControlStateNormal)];
	[self.topButton setTitleColor:(UIColorFromRGB(0x3498db)) forState:(UIControlStateNormal)];
}


//Player Reactions... dealing with actions after the game has been set into action
- (IBAction)lowerLeftButtonPressed:(id)sender {
	if((self.gameCase == 2 || self.gameCase == 3) && !self.lowerLeftTapped && !self.lowerRightTapped && self.started) {
		self.lowerLeftTapped = true;
		CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval elapsedTime = currentTime - self.startTime;
		NSInteger elapsedMs = elapsedTime * 1000;
		self.readyButton.hidden = YES;
		self.lowerLeftButton.enabled = NO;
		self.lowerRightButton.enabled = NO;
		
		//Case where bottom Wins
		if(!self.upperLeftTapped && !self.upperRightTapped) {
			[self.bottomButton setTitle:@"Winner!" forState:(UIControlStateNormal)];
			[self.topButton setTitle:@"Loser" forState:(UIControlStateNormal)];
			[self.topButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self.bottomButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self addScore:1000 to:self.bottomScore with:true];
			[self addScore:0 to:self.topScore with:false];
			
		}
		//Case where top Wins
		else {
			[self.topButton setTitle:@"Winner!" forState:(UIControlStateNormal)];
			[self.bottomButton setTitle:@"Loser" forState:(UIControlStateNormal)];
			[self.topButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self.bottomButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self addScore:1000 to:self.topScore with:true];
			[self addScore:0 to:self.bottomScore with:false];
		}
		//OTHER THINGS!!!!!!!!!!!!!!
		self.bottomTimeText.text = [NSString stringWithFormat:@"%d ms", elapsedMs];
	}
	else {
		[self misFireFrom:@"bottom"];
	}
}

- (IBAction)upperRightButtonPressed:(id)sender {
	if((self.gameCase == 2 || self.gameCase == 3) && !self.upperLeftTapped && !self.upperRightTapped && self.started) {
		self.upperRightTapped = true;
		CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval elapsedTime = currentTime - self.startTime;
		NSInteger elapsedMs = elapsedTime * 1000;
		self.readyButton.hidden = YES;
		self.upperLeftButton.enabled = NO;
		self.upperRightButton.enabled = NO;
		
		//Case where top Wins
		if(!self.lowerLeftTapped && !self.lowerRightTapped) {
			[self.topButton setTitle:@"Winner!" forState:(UIControlStateNormal)];
			[self.bottomButton setTitle:@"Loser" forState:(UIControlStateNormal)];
			[self.topButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self.bottomButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self addScore:1000 to:self.topScore with:true];
			[self addScore:0 to:self.bottomScore with:false];
		}
		//Case where bottom Wins
		else {
			[self.bottomButton setTitle:@"Winner!" forState:(UIControlStateNormal)];
			[self.topButton setTitle:@"Loser" forState:(UIControlStateNormal)];
			[self.topButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self.bottomButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self addScore:1000 to:self.bottomScore with:true];
			[self addScore:0 to:self.topScore with:false];
		}
		//OTHER THINGS!!!!!!!!!!!!!!
		[self.topTimeText setTransform:CGAffineTransformMakeRotation(-M_PI)];
		self.topTimeText.text = [NSString stringWithFormat:@"%d ms", elapsedMs];
	}
	else {
		[self misFireFrom:@"top"];
	}

}

- (IBAction)lowerRightButtonPressed:(id)sender {
	if((self.gameCase == 0 || self.gameCase == 1) && !self.lowerLeftTapped && !self.lowerRightTapped && self.started) {
		self.lowerRightTapped = true;
		CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval elapsedTime = currentTime - self.startTime;
		NSInteger elapsedMs = elapsedTime * 1000;
		self.readyButton.hidden = YES;
		self.lowerLeftButton.enabled = NO;
		self.lowerRightButton.enabled = NO;
		
		//Case where bottom Wins
		if(!self.upperLeftTapped && !self.upperRightTapped) {
			[self.bottomButton setTitle:@"Winner!" forState:(UIControlStateNormal)];
			[self.topButton setTitle:@"Loser" forState:(UIControlStateNormal)];
			[self.topButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self.bottomButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self addScore:1000 to:self.bottomScore with:true];
			[self addScore:0 to:self.topScore with:false];
		}
		//Case where top Wins
		else {
			[self.topButton setTitle:@"Winner!" forState:(UIControlStateNormal)];
			[self.bottomButton setTitle:@"Loser" forState:(UIControlStateNormal)];
			[self.topButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self.bottomButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self addScore:1000 to:self.topScore with:true];
			[self addScore:0 to:self.bottomScore with:false];
		}
		//OTHER THINGS!!!!!!!!!!!!!!
		self.bottomTimeText.text = [NSString stringWithFormat:@"%d ms", elapsedMs];
	}
	else {
		[self misFireFrom:@"bottom"];
	}
}

- (IBAction)upperLeftButtonPressed:(id)sender {
	if((self.gameCase == 0 || self.gameCase == 1) && !self.upperLeftTapped && !self.upperRightTapped && self.started) {
		self.upperLeftTapped = true;
		CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval elapsedTime = currentTime - self.startTime;
		NSInteger elapsedMs = elapsedTime * 1000;
		self.readyButton.hidden = YES;
		self.upperLeftButton.enabled = NO;
		self.upperRightButton.enabled = NO;
		
		//Case where top Wins
		if(!self.lowerLeftTapped && !self.lowerRightTapped) {
			[self.topButton setTitle:@"Winner!" forState:(UIControlStateNormal)];
			[self.bottomButton setTitle:@"Loser" forState:(UIControlStateNormal)];
			[self.topButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self.bottomButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self addScore:1000 to:self.topScore with:true];
			[self addScore:0 to:self.bottomScore with:false];
		}
		//Case where bottom Wins
		else {
			[self.bottomButton setTitle:@"Winner!" forState:(UIControlStateNormal)];
			[self.topButton setTitle:@"Loser" forState:(UIControlStateNormal)];
			[self.topButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self.bottomButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
			[self addScore:1000 to:self.bottomScore with:true];
			[self addScore:0 to:self.topScore with:false];
		}
		//OTHER THINGS!!!!!!!!!!!!!!
		[self.topTimeText setTransform:CGAffineTransformMakeRotation(-M_PI)];
		self.topTimeText.text = [NSString stringWithFormat:@"%d ms", elapsedMs];
	}
	else {
		[self misFireFrom:@"top"];
	}
}
-(IBAction)misFireFrom:(NSString *)loser {
	self.lowerLeftTapped = true;
	self.lowerRightTapped = true;
	self.upperLeftTapped = true;
	self.upperRightTapped = true;
	self.started = true;
	[self.lowerLeftButton setBackgroundColor:[UIColor redColor]];
	[self.lowerRightButton setBackgroundColor:[UIColor redColor]];
	[self.upperLeftButton setBackgroundColor:[UIColor redColor]];
	[self.upperRightButton setBackgroundColor:[UIColor redColor]];
	self.readyButton.hidden = YES;
	if([loser isEqualToString:@"top"]) {			//bottom wins
		[self.bottomButton setTitle:@"Winner!" forState:(UIControlStateNormal)];
		[self.topButton setTitle:@"Loser" forState:(UIControlStateNormal)];
		[self.topButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
		[self.bottomButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
		[self.topButton setTransform:CGAffineTransformMakeRotation(-M_PI)];
		[self addScore:1000 to:self.bottomScore with:true];
		[self addScore:0 to:self.topScore with:false];
		[self.topMisfireText setTransform:CGAffineTransformMakeRotation(-M_PI)];
		self.topMisfireText.text = @"MISFIRE";
		
		
	}
	else {			//top wins
		[self.topButton setTitle:@"Winner!" forState:(UIControlStateNormal)];
		[self.bottomButton setTitle:@"Loser" forState:(UIControlStateNormal)];
		[self.topButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
		[self.bottomButton setTitleColor:(UIColorFromRGB(0x000)) forState:(UIControlStateNormal)];
		[self.topButton setTransform:CGAffineTransformMakeRotation(-M_PI)];
		[self addScore:1000 to:self.topScore with:true];
		[self addScore:0 to:self.bottomScore with:false];
		self.bottomMisfireText.text = @"MISFIRE";

	}
	//SEGUE BACK!!!!!!
}

//Scoring
-(void) addScore:(NSInteger)timeElapsed to:(NSMutableArray *)scoreArray with:(Boolean)didWin {
	NSArray * pair = @[[NSNumber numberWithInt:timeElapsed], [NSNumber numberWithBool: didWin]];
	[scoreArray enqueue:pair];
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
