//
//  XYZColorChangeViewController.h
//  ctest
//
//  Created by CS121 on 2/19/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZColorUIView.h"
#import "NSMutableArray+QueueAdditions.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface XYZMini1ViewController : UIViewController
{
	SystemSoundID misfireSoundID;
	SystemSoundID backgroundSoundID;
	AVAudioPlayer *backgroundMusicPlayer;
}

- (IBAction)onBottomPressed:(id)sender;
- (IBAction)onTopPressed:(id)sender;
- (IBAction)gamesStart:(id)sender;

@property (nonatomic) NSMutableArray* gameSession;

//These are arrays of (NSInteger timeInMs, Boolean didWin) tuples.
@property NSMutableArray * topScore;
@property NSMutableArray * bottomScore;


@end
