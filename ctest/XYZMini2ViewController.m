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
@property (weak, nonatomic) IBOutlet UIButton *upperRightButton;
@property (weak, nonatomic) IBOutlet UIButton *upperLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *lowerRightButton;
@property (weak, nonatomic) IBOutlet UIButton *lowerLeftButton;


//booleans
@property Boolean started;
@property Boolean topTapped;
@property Boolean bottomTapped;
//startTime
@property CFTimeInterval startTime;
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
	NSLog(@"Hi");
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
}

- (IBAction)lowerRightButtonPressed:(id)sender {
}

- (IBAction)lowerLeftButtonPressed:(id)sender {
}
// GO!!!
- (void) start {
    if(!self.started){
        self.started = true;
        self.startTime = CACurrentMediaTime();
        //Say "GO!!!" in the middle.
        [self.readyButton setBackgroundColor:UIColorFromRGB(0x2ecc71)];
		//RANDOM NUMBER TIME
		int randomValue = arc4random()%4;
		if (randomValue == 0) {
			[self startWithBlueTextRedColor];
			NSLog(@"0");
		}
		if (randomValue == 1) {
			[self startWithBlueTextBlueColor];
			NSLog(@"1");
		}
		if (randomValue == 2) {
			[self startWithRedTextRedColor];
			NSLog(@"2");
		}
		if (randomValue == 3) {
			[self startWithRedTextBlueColor];
			NSLog(@"3");
		}
		
    }
}
-(void) startWithBlueTextRedColor
{
	[self.bottomButton setTitle:@"Blue" forState:(UIControlStateNormal)];
	[self.topButton setTitle:@"Blue" forState:(UIControlStateNormal)];
	[self.bottomButton setTitleColor:(UIColorFromRGB(0xf1c40f)) forState:(UIControlStateNormal)];
	[self.topButton setTitleColor:(UIColorFromRGB(0xf1c40f)) forState:(UIControlStateNormal)];
}
-(void) startWithBlueTextBlueColor
{
	[self.bottomButton setTitle:@"Blue" forState:(UIControlStateNormal)];
	[self.topButton setTitle:@"Blue" forState:(UIControlStateNormal)];
	[self.bottomButton setTitleColor:(UIColorFromRGB(0x2c3e50)) forState:(UIControlStateNormal)];
	[self.topButton setTitleColor:(UIColorFromRGB(0x2c3e50)) forState:(UIControlStateNormal)];
}
-(void) startWithRedTextRedColor
{
	[self.bottomButton setTitle:@"Red" forState:(UIControlStateNormal)];
	[self.topButton setTitle:@"Red" forState:(UIControlStateNormal)];
	[self.bottomButton setTitleColor:(UIColorFromRGB(0xf1c40f)) forState:(UIControlStateNormal)];
	[self.topButton setTitleColor:(UIColorFromRGB(0xf1c40f)) forState:(UIControlStateNormal)];
}
-(void) startWithRedTextBlueColor
{
	[self.bottomButton setTitle:@"Red" forState:(UIControlStateNormal)];
	[self.topButton setTitle:@"Red" forState:(UIControlStateNormal)];
	[self.bottomButton setTitleColor:(UIColorFromRGB(0x2c3e50)) forState:(UIControlStateNormal)];
	[self.topButton setTitleColor:(UIColorFromRGB(0x2c3e50)) forState:(UIControlStateNormal)];
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
