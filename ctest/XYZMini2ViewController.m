//
//  XYZMini2ViewController.m
//  ctest
//
//  Created by Billy Mills on 4/14/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import "XYZMini2ViewController.h"

@interface XYZMini2ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *readyButton;
@property (weak, nonatomic) IBOutlet UIView *player1LeftView;
@property (weak, nonatomic) IBOutlet UIView *player2LeftView;
@property (weak, nonatomic) IBOutlet UIView *player1RightView;
@property (weak, nonatomic) IBOutlet UIView *player2RightView;
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
// GO!!!
- (void) start {
    if(!self.started){
        self.started = true;
        self.startTime = CACurrentMediaTime();
        //Say "GO!!!" in the middle.
        [self.readyButton setBackgroundColor:UIColorFromRGB(0x2ecc71)];
    }
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
