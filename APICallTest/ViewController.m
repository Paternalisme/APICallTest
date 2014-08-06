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
    restCallString = @"http://8tracks.com/mix_sets/tags:live.json?include=tag_cloud+mixes&api_version=3&api_key=f3a1edd4dba9ad0679f06d846b58814df1a24122";
}

- (IBAction)tag1Button:(id)sender {
    
    [self makeTagAPICall];

}


- (void) makeTagAPICall
{
    APITagCall *tagCall = [[APITagCall alloc] initWithURL:restCallString];
    
    NSArray *tags = [tagCall tags];
    
    y = self.tagCloud.bounds.origin.y;
    for (id object in tags)
    {
        NSString *status = [object valueForKey:@"name"];
        NSLog(@"%@", status);
        
        
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
    
    
    UIButton *button = (UIButton *)sender;
    NSString *buttonTitle = button.currentTitle;
    
    buttonTitle = [@"+" stringByAppendingString:buttonTitle];
    
    buttonTitle = [buttonTitle stringByAppendingString:@".json"];
    
    buttonTitle = [buttonTitle stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    restCallString = [restCallString stringByReplacingOccurrencesOfString:@".json" withString:buttonTitle];
    
    NSLog(@"%@",restCallString);
    
    [self makeTagAPICall];
}

- (IBAction)playButton:(id)sender {
    playCall = [[APICall alloc] init];
    [playCall getPlayToken];
    playToken = [playCall playToken];
    NSLog(@"playtoken : %@",playToken);

    APITagCall *tagCall = [[APITagCall alloc] initWithURL:restCallString];
    mixId = [tagCall mixId];
    
    APICallAudioUrl *audioCall = [[APICallAudioUrl alloc] init];
    [audioCall getAudioURL:mixId :playToken];
    NSString *audioURL = [audioCall audioURL];
    NSLog(@"audioURL: %@", audioURL);
    
    
    NSError *error = nil;
    self.audioPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:audioURL]];
    if (error)
        NSLog(@"hallo");
    [self.audioPlayer play];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
