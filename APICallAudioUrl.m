//
//  APICallAudioUrl.m
//  APICallTest
//
//  Created by mac mini on 05/08/14.
//  Copyright (c) 2014 ___Papapapapow___. All rights reserved.
//

#import "APICallAudioUrl.h"

@implementation APICallAudioUrl

- (id) init
{
    self = [super init];
    
    
    
    return self;
}

-(NSString *) audioURL
{
    return audioURL;
}

- (void) getAudioURL:(NSString *)mixId :(NSString *)playToken {
    
    NSString *restCallString = @"";
    restCallString = [restCallString stringByAppendingFormat:@"http://8tracks.com/sets/%@/play.json?mix_id=%@&api_version=3&api_key=f3a1edd4dba9ad0679f06d846b58814df1a24122", playToken, mixId];
    
    NSURL *restURL = [NSURL URLWithString:restCallString];
    NSURLRequest *restRequest = [NSURLRequest requestWithURL:restURL];
     
    NSURLResponse *apiPlayReturn2;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:restRequest returningResponse:&apiPlayReturn2 error:&error];
    if (data){
        NSError *localError = nil;
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&localError];
        if (localError)
            NSLog(@"JSONObjectWithData error: %@", localError);
        NSDictionary *set = [parsedObject valueForKey:@"set"];
        NSDictionary *track = [set valueForKey:@"track"];
        audioURL = [track valueForKey:@"track_file_stream_url"];
        NSLog(@"%@", audioURL);
    }
    else{
        //check error domain and code
    }
}


@end
