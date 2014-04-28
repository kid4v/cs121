//
//  XYZColorChangeViewController.m
//  ctest
//
//  Created by CS121 on 2/19/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//
#import "XYZMini3ViewController.h"
#import "XYZSummaryViewController.h"


@interface XYZMini3ViewController ()

@property Boolean started;
@property Boolean ended;
@property unsigned topCount;
@property unsigned botCount;
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

@implementation XYZMini3ViewController

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
	
	// Fonts:
    //	self.readyButton.titleLabel.font = [UIFont fontWithName:@"MoonFlowerBold" size: 57];
    //	self.topTextBox.font = [UIFont fontWithName:@"MoonFlowerBold" size: 38];
    //	self.bottomTextBox.font = [UIFont fontWithName:@"MoonFlowerBold" size: 38];
    //	self.topTimeBox.font = [UIFont fontWithName:@"MoonFlowerBold" size: 35];
    //	self.bottomTimeBox.font = [UIFont fontWithName:@"MoonFlowerBold" size: 35];
	// Misfire Sound
	NSURL *misfireSoundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beep_beep" ofType: @"wav"]];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef) misfireSoundURL, &misfireSoundID);
	// Background Sound
	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/God.mp3", [[NSBundle mainBundle] resourcePath]]];
	backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
	backgroundMusicPlayer.numberOfLoops = -1;
	
	if (backgroundMusicPlayer == nil)
		NSLog(@"Error loading background music");
	else
		[backgroundMusicPlayer play];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    
    //If this game is over...
    else if ([self isOver]){
        //check for more games in gameSession
        if ([self.gameSession count] == 0) {
            [self.readyButton setTitle:@"GAME OVER" forState:UIControlStateNormal];
            self.readyButton.enabled = NO;
        } else {
            NSString * segue;  // = [NSString stringWithFormat: @"%@", [self.gameSession dequeue]];
            //if next gamew is also 1, use self1 segue.
            if ([segue isEqualToString:@"3"]){
                segue = [NSString stringWithFormat:@"self%@", [self.gameSession dequeue]];
            }
            [self performSegueWithIdentifier:segue sender:sender];
        }
    }
}

- (bool) isOver{
    return self.started && !self.ended;
}
- (void) setup
{
    self.bottomTapped = false;
    self.topTapped = false;
    self.started = false;
    
    self.readyButton.enabled = YES;
    
    self.topTextBox.text = @"";
    self.topTimeBox.text = @"";
    self.bottomTextBox.text = @"";
    self.bottomTimeBox.text = @"";
}

// GO!!!
- (void) start {
    if(!self.started){
        self.started = true;
        self.startTime = CACurrentMediaTime();

        //turn button green
        [self.readyButton setBackgroundColor:UIColorFromRGB(0x2ecc71)];
        [NSTimer scheduledTimerWithTimeInterval:5 target:self
                                       selector:@selector(end)
                                       userInfo:nil
                                        repeats:NO];
		//Change color to set off the competition
        //        self.topView.backgroundColor = UIColorFromRGB(0xFFDB4D);
        //        self.bottomView.backgroundColor = UIColorFromRGB(0xFFDB4D);
        
    }
}

- (void) end {
    [self.topTimeBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
    [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];

    self.topTimeBox.text = [NSString stringWithFormat:@"You scored: %u", self.topCount*100];
    self.bottomTimeBox.text = [NSString stringWithFormat:@"You scored: %u", self.botCount*100];
    self.ended = true;
    self.readyButton.hidden = true;

    
    if(self.topCount>self.botCount){
        self.bottomView.backgroundColor = [UIColor redColor];
        self.topView.backgroundColor = UIColorFromRGB(0x2ecc71);
        [self addScore:self.topCount*100 to:self.topScore with:false];
        [self addScore:self.botCount*100 to:self.bottomScore with:true];
        self.topTextBox.text = @"You Win!";
        self.bottomTextBox.text = @"You Lose";
    }
    else if (self.topCount<self.botCount){
        self.topView.backgroundColor = [UIColor redColor];
        self.bottomView.backgroundColor = UIColorFromRGB(0x2ecc71);
        [self addScore:self.botCount*100 to:self.bottomScore with:true];
        [self addScore:self.topCount*100 to:self.topScore with:true];
        self.topTextBox.text = @"You Lose";
        self.bottomTextBox.text = @"You Win!";
    }
    else{
        self.topView.backgroundColor = [UIColor yellowColor];
        self.bottomView.backgroundColor = [UIColor yellowColor];
        [self addScore:self.botCount*100 to:self.bottomScore with:true];
        [self addScore:self.topCount*100 to:self.topScore with:true];
        self.topTextBox.text = @"Tie!";
        self.bottomTextBox.text = @"Tie!";
    }
    [self performSelector:@selector(segueBack) withObject:nil afterDelay:3];
}

// The scores are paired with Boolean values that specify wins/losses in case
// we implement green/red coloring in the SummaryViewController display.
- (void) addScore:(NSInteger)timeElapsed to:(NSMutableArray*)scoreArray with:(Boolean)didWin {
    NSArray * pair = @[[NSNumber numberWithInt:timeElapsed], [NSNumber numberWithBool:didWin]];
    [scoreArray enqueue:pair];
}

- (IBAction)onBottomPressed:(id)sender {
    //prevent false updates
    if (!self.bottomTapped && self.started){
        self.botCount++;
    }
    
}
- (IBAction)onTopPressed:(id)sender {
    
    //prevent false update
    if (self.started && !self.ended){
        self.topCount++;
    }}


-(void) segueBack {
	[backgroundMusicPlayer stop];
    [self performSegueWithIdentifier:@"from3" sender:self];
}

//passes the gameSession array along the segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    XYZSummaryViewController *destViewController = (XYZSummaryViewController *)segue.destinationViewController;
    destViewController.gameSession = self.gameSession;
    destViewController.bottomScore = self.bottomScore;
    destViewController.topScore = self.topScore;
}
@end
