//
//  APICall.m
//  APICallTest
//
//  Created by mac mini on 04/08/14.
//  Copyright (c) 2014 ___Papapapapow___. All rights reserved.
//

#import "APICall.h"

@implementation APICall

- (id) init
{
    self = [super init];
    
    return self;
}

-(NSString *) playToken
{
    return playToken;
}

- (void) getPlayToken
{
    
    NSString *restCallString = @"http://8tracks.com/sets/new.json?api_version=3&api_key=f3a1edd4dba9ad0679f06d846b58814df1a24122";
    
    NSURL *restURL = [NSURL URLWithString:restCallString];
    NSURLRequest *restRequest = [NSURLRequest requestWithURL:restURL];
    
    NSURLResponse *apiPlayReturn2;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:restRequest returningResponse:&apiPlayReturn2 error:&error];
    if(data){
        NSError *localError = nil;
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&localError];
        if (localError)
        NSLog(@"JSONObjectWithData error: %@", localError);
        playToken = [parsedObject valueForKey:@"play_token"];
    }
    else{
        //check error domain and code
    }
    
}


@end
