//
//  XYZColorChangeViewController.m
//  ctest
//
//  Created by CS121 on 2/19/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//
#import "XYZMini1ViewController.h"
#import "XYZSummaryViewController.h"


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
            //if next game is also 1, use self1 segue.
            if ([segue isEqualToString:@"1"]){
                segue = [NSString stringWithFormat:@"self%@", [self.gameSession dequeue]];
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
		//Change color to set off the competition
//        self.topView.backgroundColor = UIColorFromRGB(0xFFDB4D);
//        self.bottomView.backgroundColor = UIColorFromRGB(0xFFDB4D);
        
    }
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
        //we won so we just set the color eventaully we will record the time too
        self.bottomTapped = true;
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval elapsedTime = currentTime - self.startTime;
        NSInteger elapsedMs = elapsedTime * 1000;
		self.readyButton.hidden = YES;
        
        //bottom wins
        if (!self.topTapped){
            self.bottomTextBox.text = @"You won!";
            self.bottomView.backgroundColor = UIColorFromRGB(0x2ecc71);
            
            [self addScore:elapsedMs to:self.bottomScore with:true];
        }
        
        //top wins
        else {
            self.bottomView.backgroundColor = [UIColor redColor];
            self.bottomTextBox.text = @"You Lost";

			
			//accumulate scoring
            [self addScore:elapsedMs to:self.bottomScore with:false];
            
            //wait 3 sec before segue back to summary view
            [self performSelector:@selector(segueBack) withObject:nil afterDelay:3];
        }
        
        //display time
        self.bottomTimeBox.text = [NSString stringWithFormat:@"%d ms", elapsedMs];
        
        
    }
    else if (!self.started && !self.bottomTapped){
        [self addScore:1000 to:self.bottomScore with:false];
        [self addScore:0 to:self.topScore with:true];
        [self misFireFrom:self.bottomTextBox and:self.topTextBox];
    }
    
}
- (IBAction)onTopPressed:(id)sender {
    
    //prevent false update
    if (!self.topTapped && self.started){
        self.topTapped = true;
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval elapsedTime = currentTime - self.startTime;
        NSInteger elapsedMs = elapsedTime * 1000;
		self.readyButton.hidden = YES;
        
        //top wins
        if (!self.bottomTapped){
            self.topView.backgroundColor = UIColorFromRGB(0x2ecc71);
            [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
            self.topTextBox.text = @"You won!";
            
            [self addScore:elapsedMs to:self.topScore with:true];
            
        }
        //bottom wins
        else {
            self.topView.backgroundColor = [UIColor redColor];
            [self.topTextBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
            self.topTextBox.text = @"You Lost";

            
            [self addScore:elapsedMs to:self.topScore with:false];
            
            //wait 3 sec before segue back to summary view
            [self performSelector:@selector(segueBack) withObject:nil afterDelay:3];
        }
        
        [self.topTimeBox setTransform:CGAffineTransformMakeRotation(-M_PI)];
        self.topTimeBox.text = [NSString stringWithFormat:@"%d ms",elapsedMs];
        
    }
    else if (!self.started && !self.topTapped){
        [self addScore:1000 to:self.topScore with:false];
        [self addScore:0 to:self.bottomScore with:true];
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
    winner.text = @"Misfire—you win!";
    loser.text = @"Misfire—you lose!";
    [self.readyButton setTitle:@"" forState:UIControlStateNormal];
    AudioServicesPlaySystemSound(misfireSoundID);
	self.readyButton.hidden = YES;
	
    //wait 3 sec before segue back to summary view
    
    [self performSelector:@selector(segueBack) withObject:nil afterDelay:3];
}

-(void) segueBack {
	[backgroundMusicPlayer stop];
    [self performSegueWithIdentifier:@"from1" sender:self];
}

//passes the gameSession array along the segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    XYZSummaryViewController *destViewController = (XYZSummaryViewController *)segue.destinationViewController;
    destViewController.gameSession = self.gameSession;
    destViewController.bottomScore = self.bottomScore;
    destViewController.topScore = self.topScore;
}
@end
