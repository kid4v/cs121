//
//  XYZColorChangeViewController.m
//  ctest
//
//  Created by CS121 on 2/19/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//
#import "XYZColorChangeViewController.h"

@interface XYZColorChangeViewController ()
@property Boolean over;
@property (weak, nonatomic) IBOutlet XYZColorUIView *topView;
@property (weak, nonatomic) IBOutlet XYZColorUIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *topTextBox;
@property (weak, nonatomic) IBOutlet UILabel *bottomTextBox;
@property (weak, nonatomic) IBOutlet UILabel *topTimeBox;
@property (weak, nonatomic) IBOutlet UILabel *bottomTimeBox;
@property Boolean topTaped;
@property Boolean bottomTapped;
@property CFTimeInterval startTime;


@end

@implementation XYZColorChangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.startTime = CACurrentMediaTime();
        self.bottomTapped = false;
        self.topTaped = false;
        self.over = false;

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBottomPressed:(id)sender {
    //prevent false updates
    if (!self.bottomTapped){
        //we won so we just set the color eventaully we will record the time too
        self.bottomTapped = true;
        self.bottomView.backgroundColor = [UIColor redColor];
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval howFast = currentTime - self.startTime;

        if (!self.over){
            self.over = true;
            self.bottomTextBox.text = @"You won!";

        }
        else {
            self.bottomTextBox.text = @"You Lost";
        }

        self.bottomTimeBox.text = [NSString stringWithFormat:@"%f",howFast];
    }
    
}
- (IBAction)onTopPressed:(id)sender {
    
    //prevent false update
if (!self.topTaped){
    self.topTaped = true;
    CFTimeInterval currentTime = CACurrentMediaTime();
    CFTimeInterval howFast = currentTime - self.startTime ;
    if (!self.over){
        self.over = true;

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
}
@end
