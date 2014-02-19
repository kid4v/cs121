//
//  ViewController.m
//  Stopwatch
//
//  Created by Kevin Byrne on 2/17/14.
//  Copyright (c) 2014 Kevin Byrne. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/CAAnimation.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *display;

- (IBAction)buttonPressed:(id)sender;

@end

@implementation ViewController {
    
    bool start;
    
//    NSTimeInterval time;
    CFTimeInterval time;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    Uncomment for upside-down label
//    [self.display setTransform:CGAffineTransformMakeRotation(-M_PI)];
    
//    self.display.text = @"0:00.000";
    self.display.text = @"";

    start = false;

}

- (void) update {
    if (start == false) {
        return;
    }
    CFTimeInterval currentTime = CACurrentMediaTime();
    CFTimeInterval elapsedTime = (currentTime - time);
    
    int minutes = (int)(elapsedTime / 60);
    int seconds = (int)(elapsedTime - (minutes * 60));
    int millis = (int)((elapsedTime - (minutes*60) - seconds) * 1000);
    self.display.text = [NSString stringWithFormat:@"%u:%02u.%03u", minutes, seconds, millis];
    
    [self performSelector:@selector(update) withObject:self afterDelay:0.001];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    if (start == false) {
        start = true;
        self.display.text = @"";
        time = CACurrentMediaTime();
        [sender setTitle:@"Stop!" forState:UIControlStateNormal];
   
//        [self update];
    } else {
        start = false;
        
        //when update isn't used and silent stopwatch is desired:
        CFTimeInterval currentTime = CACurrentMediaTime();
        CFTimeInterval elapsedTime = (currentTime - time);
        
        int minutes = (int)(elapsedTime / 60);
        int seconds = (int)(elapsedTime - (minutes * 60));
        int millis = (int)((elapsedTime - (minutes*60) - seconds) * 1000);
        self.display.text = [NSString stringWithFormat:@"%u:%02u.%03u", minutes, seconds, millis];
        
        
        [sender setTitle:@"Start" forState:UIControlStateNormal];
    }
}
@end
