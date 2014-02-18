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
    
    NSTimeInterval time;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.display.text = @"0:00.000";
    start = false;

}

- (void) update {
    if (start == false) {
        return;
    }
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsedTime = (currentTime - time);
    
    // 121.333 seconds
    int minutes = (int)(elapsedTime / 60);
    int seconds = (int)(elapsedTime - (minutes * 60));
    int millis = (int)((elapsedTime - (minutes*60) - seconds) * 1000);
    self.display.text = [NSString stringWithFormat:@"%u:%02u.%03u", minutes, seconds, millis];
    
    [self performSelector:@selector(update) withObject:self afterDelay:0.1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    if (start == false) {
        start = true;
        time = [NSDate timeIntervalSinceReferenceDate];
        [sender setTitle:@"Stop!" forState:UIControlStateNormal];
   
        [self update];
    } else {
        start = false;
        [sender setTitle:@"Start" forState:UIControlStateNormal];
    }
}
@end
