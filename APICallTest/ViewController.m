//
//  ViewController.m
//  APICallTest
//
//  Created by mac mini on 31/07/14.
//  Copyright (c) 2014 ___Papapapapow___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    x = 50;
    y = self.tagCloud.bounds.origin.y;
    xh = self.previousTag.bounds.origin.x;
    yh = self.previousTag.bounds.origin.y;
    xc = self.coversScroll.bounds.origin.x;
    yc = self.coversScroll.bounds.origin.y;
    endOfMixFlag = @(NO);
    
    restCallString = @"http://8tracks.com/mix_sets/tags:live.json?include=tag_cloud+mixes+details&api_version=3&api_key=f3a1edd4dba9ad0679f06d846b58814df1a24122";
    
    [self.trackProgressBar setUserInteractionEnabled:NO];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(getNextTrack)
     name:AVPlayerItemDidPlayToEndTimeNotification
     object:self.audioPlayer];
    [NSTimer scheduledTimerWithTimeInterval:1.0
        target:self
        selector:@selector(reportTrack)
        userInfo:nil
        repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:1.0
        target:self
        selector:@selector(setTrackProgressBar)
        userInfo:nil
        repeats:YES];
}

- (void) setTrackProgressBar
{
    float percentage = CMTimeGetSeconds([self.audioPlayer currentTime]) * 100 / trackDuration;
    self.trackProgressBar.progress = percentage / 100;
}

- (void) getNextTrack
{
    if ([endOfMixFlag  isEqual: @(YES)]) {
        NSLog(@"NEXT MIX");
        NSString *URL = @"";
        [APINextMixCall getNextMix:[URL stringByAppendingFormat:@"http://8tracks.com/sets/%@/next_mix.json?mix_id=%@&api_version=3&api_key=f3a1edd4dba9ad0679f06d846b58814df1a24122", playToken, mixId] completion:^(NSString *aMixId)
        {
            mixId = aMixId;
            APICallAudioUrl *audioCall = [[APICallAudioUrl alloc] init];
            [audioCall getAudioURL:mixId :playToken :1 :^(NSString *aURL, NSString *aTrackId, NSNumber *isEnd)
            {
                endOfMixFlag = isEnd;
                audioURL = aURL;
                trackId = aTrackId;
                NSLog(@"audioURL: %@", audioURL);
                NSError *error = nil;
                self.audioPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:audioURL]];
                if (error)
                    NSLog(@"hallo");
                CMTime duration = self.audioPlayer.currentItem.asset.duration;
                trackDuration = CMTimeGetSeconds(duration);
                [self.audioPlayer play];
            }];
        }];
    }
    else
    {
        NSLog(@"NEXT TRACK");
        APICallAudioUrl *audioCall = [[APICallAudioUrl alloc] init];
        [audioCall getAudioURL:mixId :playToken :1 :^(NSString *aURL, NSString *aTrackId, NSNumber *isEnd){
            endOfMixFlag = isEnd;
            audioURL = aURL;
            trackId = aTrackId;
            NSLog(@"audioURL: %@", audioURL);
            NSError *error = nil;
            self.audioPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:audioURL]];
            if (error)
                NSLog(@"hallo");
            CMTime duration = self.audioPlayer.currentItem.asset.duration;
            trackDuration = CMTimeGetSeconds(duration);
            [self.audioPlayer play];
        }];
    }
}

- (void) reportTrack
{
    if (CMTimeGetSeconds([self.audioPlayer currentTime]) >= 30.0 && CMTimeGetSeconds([self.audioPlayer currentTime]) < 31.0)
    {
        if (!requestFlag)
        {
            NSString *URL = @"";
            URL = [URL stringByAppendingFormat:@"http://8tracks.com/sets/%@/report.json?track_id=%@&mix_id=%@", playToken, trackId, mixId];
            [APIReportCall makeReportCall:URL];
            NSLog(@"REPORT %f", CMTimeGetSeconds([self.audioPlayer currentTime]));
            requestFlag = YES;
        }
    }
    else
    {
        requestFlag = NO;
        NSLog(@"wait %f", CMTimeGetSeconds([self.audioPlayer currentTime]));
    }
}

- (IBAction)tag1Button:(id)sender {
    
    [self makeTagAPICall];
    [self controlWithPreviousTag];
    [self controlForCoversScroll];

}

- (void) makeTagAPICall
{
    [APITagCall initWithURL:restCallString completion:^(NSString *anId, NSArray *anArray, NSArray *anArray2, NSDictionary *aDictionary){

        NSArray *tags = anArray;
        
        y = self.tagCloud.bounds.origin.y;
        for (id object in tags)
        {
            NSString *status = [object valueForKey:@"name"];
            //        NSLog(@"%@", status);
            //create the button
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            //set the position of the button
            button.frame = CGRectMake(x, y, 150, 20);
            //set the button's title
            [button setTitle:(status) forState:UIControlStateNormal];
            //add the button to the view
            [self.tagCloud addSubview:button];
            //link the action with the button
            [button addTarget:self action:@selector(add_tag:) forControlEvents:
             UIControlEventTouchUpInside];
            
            y += 20;
        }
        
        float tagCloudHeight = 0;
        for (UIView *view in self.tagCloud.subviews)
        {
            tagCloudHeight += view.frame.size.height;
        }
        [self.tagCloud setContentSize:(CGSizeMake(50, tagCloudHeight))];

    }];
    
}

- (void) controlWithPreviousTag
{
    
    [APITagCall initWithURL:restCallString completion:^(NSString *anId, NSArray *anArray, NSArray *anArray2, NSDictionary *aDictionary){
        
        NSArray *tagsList = anArray2;
    
    xh = self.previousTag.bounds.origin.x;
    for (NSString *object in tagsList)
    {
        if (![object  isEqual: @"live"])
        {
            /*NSString *status = [object valueForKey:@"name"];*/
            NSLog(@"%@", object);
            NSString *tmp = object;
            tmp = [tmp stringByAppendingString:@" X"];
            //create the button
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            //set the position of the button
            button.frame = CGRectMake(xh, yh, 100, 20);
            //set the button's title
            [button setTitle:(tmp) forState:UIControlStateNormal];
            //add the button to the view
            [self.previousTag addSubview:button];
            //link the action with the button
            [button addTarget:self action:@selector(sub_tag:) forControlEvents:
             UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
            
            xh += 100;
        }
    }
    
    float tagCloudHeight = 0;
    for (UIView *view in self.previousTag.subviews)
    {
        tagCloudHeight += view.frame.size.width;
    }
    [self.previousTag setContentSize:(CGSizeMake(tagCloudHeight, 50))];
        }];
}


- (void) controlForCoversScroll
{
    [APITagCall initWithURL:restCallString completion:^(NSString *anId, NSArray *anArray, NSArray *anArray2, NSDictionary *aDictionary){
        
        NSDictionary *coversUrl = aDictionary;
        
        xc = self.coversScroll.bounds.origin.x;
        yc = self.coversScroll.bounds.origin.x;
        
        //for (NSString *object in coversUrl) {
        
        
        
        NSString *url = [coversUrl valueForKey:(@"sq100")];
        
        [self.test sd_setImageWithURL:[NSURL URLWithString:url]
                     placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                            completed:^(UIImage *image, NSError *error,SDImageCacheType cacheType, NSURL *imageURL) {
        
                                self.test.frame = CGRectMake(self.test.frame.origin.x, self.test.frame.origin.y,
                                                             image.size.width/2, image.size.height/2 );
                                
                            
                            }];
        
        
        
        
    }];
}



//button action
- (IBAction)add_tag:(UIButton *)sender
{
    
    float tagCloudHeight = 0;
    for (UIView *view in self.tagCloud.subviews)
    {
        [view removeFromSuperview];
        tagCloudHeight -= view.frame.size.height;
    }
    [self.tagCloud setContentSize:(CGSizeMake(50, tagCloudHeight))];
    currentConnection = nil;
    
    for (UIView *view in self.previousTag.subviews)
    {
        [view removeFromSuperview];
        tagCloudHeight -= view.frame.size.height;
    }
    [self.previousTag setContentSize:(CGSizeMake(tagCloudHeight, 50))];
    currentConnection = nil;
    UIButton *button = (UIButton *)sender;
    NSString *buttonTitle = button.currentTitle;
    buttonTitle = [@"+" stringByAppendingString:buttonTitle];
    buttonTitle = [buttonTitle stringByAppendingString:@".json"];
    buttonTitle = [buttonTitle stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    restCallString = [restCallString stringByReplacingOccurrencesOfString:@".json" withString:buttonTitle];
    NSLog(@"%@",restCallString);
    [self makeTagAPICall];
    [self controlWithPreviousTag];
    [self controlForCoversScroll];

}

- (IBAction)sub_tag:(UIButton *)sender
{
        
        float tagCloudHeight = 0;
        for (UIView *view in self.tagCloud.subviews)
        {
            [view removeFromSuperview];
            tagCloudHeight -= view.frame.size.height;
        }
    
        [self.tagCloud setContentSize:(CGSizeMake(50, tagCloudHeight))];
        currentConnection = nil;
        
        
        for (UIView *view in self.previousTag.subviews)
        {
            [view removeFromSuperview];
            tagCloudHeight -= view.frame.size.height;
        }
        [self.previousTag setContentSize:(CGSizeMake(tagCloudHeight, 50))];
        currentConnection = nil;
    
        UIButton *button = (UIButton *)sender;
        NSString *buttonTitle = button.currentTitle;
        buttonTitle = [@"+" stringByAppendingString:buttonTitle];
        buttonTitle = [buttonTitle stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        buttonTitle = [buttonTitle stringByReplacingOccurrencesOfString:@"_X" withString:@"+"];
        restCallString = [restCallString stringByReplacingOccurrencesOfString:buttonTitle withString:@"+"];
        restCallString = [restCallString stringByReplacingOccurrencesOfString:buttonTitle withString:@"+"];
        buttonTitle = [buttonTitle stringByReplacingOccurrencesOfString:@"+" withString:@""];
        buttonTitle = [@"+" stringByAppendingString:buttonTitle];
        buttonTitle = [buttonTitle stringByAppendingString:@".json"];
        restCallString = [restCallString stringByReplacingOccurrencesOfString:buttonTitle withString:@".json"];
        NSLog(@"%@",restCallString);
        [self makeTagAPICall];
        [self controlWithPreviousTag];
        [self controlForCoversScroll];
    
    }







- (IBAction)playButton:(id)sender {
    if ([self.audioPlayer currentTime].value == 0)
    {
    playCall = [[APICall alloc] init];
        [playCall getPlayToken:^(NSString *aToken){
            playToken = aToken;
            NSLog(@"playtoken : %@",playToken);
            [APITagCall initWithURL:restCallString completion:^(NSString *anId, NSArray *anArray, NSArray *anArray2, NSDictionary *aDictionnary) {
                mixId = anId;
                APICallAudioUrl *audioCall = [[APICallAudioUrl alloc] init];
                [audioCall getAudioURL:mixId :playToken :0 :^(NSString *aURL, NSString *aTrackId, NSNumber *isEnd){
                    audioURL = aURL;
                    trackId = aTrackId;
                    NSLog(@"audioURL: %@", audioURL);
                    
                    
                    NSError *error = nil;
                    self.audioPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:audioURL]];
                    if (error)
                        NSLog(@"hallo");
                    CMTime duration = self.audioPlayer.currentItem.asset.duration;
                    trackDuration = CMTimeGetSeconds(duration);
                    [self.audioPlayer play];

                }];
            }];
            
        }];
        
    }
    [self.audioPlayer play];
}

- (IBAction)pauseButton:(id)sender {
    [self.audioPlayer pause];
}

- (IBAction)nextButton:(id)sender {
    NSLog(@"%@", endOfMixFlag);
    if ([endOfMixFlag  isEqual: @(YES)]) {
        NSLog(@"NEXT MIX");
        NSString *URL = @"";
        [APINextMixCall getNextMix:[URL stringByAppendingFormat:@"http://8tracks.com/sets/%@/next_mix.json?mix_id=%@&api_version=3&api_key=f3a1edd4dba9ad0679f06d846b58814df1a24122", playToken, mixId] completion:^(NSString *aMixId)
         {
             mixId = aMixId;
             APICallAudioUrl *audioCall = [[APICallAudioUrl alloc] init];
             [audioCall getAudioURL:mixId :playToken :1 :^(NSString *aURL, NSString *aTrackId, NSNumber *isEnd){
            

                 endOfMixFlag = isEnd;
                 audioURL = aURL;
                 trackId = aTrackId;
                 NSLog(@"audioURL: %@", audioURL);
                 NSError *error = nil;
                 self.audioPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:audioURL]];
                 if (error)
                     NSLog(@"hallo");
                 CMTime duration = self.audioPlayer.currentItem.asset.duration;
                 trackDuration = CMTimeGetSeconds(duration);
                 [self.audioPlayer play];
             }];
         }];
    }
    else
    {

    APICallAudioUrl *audioCall = [[APICallAudioUrl alloc] init];
    [audioCall getAudioURL:mixId :playToken :2 :^(NSString *aURL, NSString *aTrackId, NSNumber *isEnd){
        if ([aURL isEqualToString:@"notAllowed"])
            NSLog(@"NOT SKIPABLE");
        else
        {
        endOfMixFlag = isEnd;
        audioURL = aURL;
        trackId = aTrackId;
        NSLog(@"audioURL: %@", audioURL);
        
        
        NSError *error = nil;
        self.audioPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:audioURL]];
        if (error)
            NSLog(@"hallo");
        CMTime duration = self.audioPlayer.currentItem.asset.duration;
        trackDuration = CMTimeGetSeconds(duration);
        [self.audioPlayer play];
        }
    }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end