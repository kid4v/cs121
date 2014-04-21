//
//  XYZMini2ViewController.h
//  ctest
//
//  Created by Billy Mills on 4/14/14.
//  Copyright (c) 2014 CS121. All rights reserved.
//

#import <UIKit/UIKit.h>


////RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface XYZMini2ViewController : UIViewController
//buttons
- (IBAction)readyButtonPressed:(id)sender;
- (IBAction)lowerLeftButtonPressed:(id)sender;
- (IBAction)upperLeftButtonPressed:(id)sender;
- (IBAction)lowerRightButtonPressed:(id)sender;
- (IBAction)upperRightButtonPressed:(id)sender;
//scoring -- (NSInteger time in MS, Boolean didWin) tuples.
@property NSMutableArray * topScore;
@property NSMutableArray * bottomScore;
@end

