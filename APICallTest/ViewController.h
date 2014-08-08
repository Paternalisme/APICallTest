//
//  ViewController.h
//  APICallTest
//
//  Created by mac mini on 31/07/14.
//  Copyright (c) 2014 ___Papapapapow___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "APICall.h"
#import "APICallAudioUrl.h"
#import "APITagCall.h"
#import "APIReportCall.h"
#import "APINextMixCall.h"
#import "UIImageView+WebCache.h"

@interface ViewController : UIViewController
{
    BOOL requestFlag;
    NSURLConnection *currentConnection;
    APICall *playCall;
    int x;
    int y;
    int xh;
    int yh;
    int xc;
    int yc;
    float trackDuration;
    NSNumber *endOfMixFlag;
    NSString *mixId;
    NSString *playToken;
    NSString *restCallString;
    NSString *audioURL;
    NSString *trackId;
}


@property (weak, nonatomic) IBOutlet UIProgressView *trackProgressBar;
@property (nonatomic, retain) AVPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIScrollView *tagCloud;
@property (weak, nonatomic) IBOutlet UIScrollView *previousTag;
@property (retain, nonatomic) NSMutableData *apiReturnXMLData;
@property (retain, nonatomic) NSMutableData *apiPlayReturn;
@property (nonatomic) NSInteger statusNbr;
@property (copy, nonatomic) NSString *currentElement;
@property (weak, nonatomic) IBOutlet UIButton *tag1Button;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *NextButton;
@property (weak, nonatomic) IBOutlet UIImageView *test;
@property (weak, nonatomic) IBOutlet UIScrollView *coversScroll;


@end
