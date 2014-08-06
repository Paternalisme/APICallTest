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

@interface ViewController : UIViewController
{
    NSURLConnection *currentConnection;
    APICall *playCall;
    int x;
    int y;
    NSString *mixId;
    NSString *playToken;
    NSString *restCallString;
}

@property (nonatomic, retain) AVPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIScrollView *tagCloud;
@property (retain, nonatomic) NSMutableData *apiReturnXMLData;
@property (retain, nonatomic) NSMutableData *apiPlayReturn;
@property (nonatomic) NSInteger statusNbr;
@property (copy, nonatomic) NSString *currentElement;
@property (weak, nonatomic) IBOutlet UIButton *tag1Button;
@property (weak, nonatomic) IBOutlet UIButton *playButton;



@end
