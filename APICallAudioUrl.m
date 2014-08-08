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

- (void) getAudioURL:(NSString *)mixId :(NSString *)playToken :(int)flag :(void(^)(NSString *, NSString *, NSNumber *))completion
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    NSString *restCallString = @"";
    if (flag == 0)
    {
       restCallString = [restCallString stringByAppendingFormat:@"http://8tracks.com/sets/%@/play.json?mix_id=%@&api_version=3&api_key=f3a1edd4dba9ad0679f06d846b58814df1a24122", playToken, mixId];
    }
   else if (flag == 1)
   {
     restCallString = [restCallString stringByAppendingFormat:@"http://8tracks.com/sets/%@/next.json?mix_id=%@&api_version=3&api_key=f3a1edd4dba9ad0679f06d846b58814df1a24122", playToken, mixId];   
   }
   else if (flag == 2)
   {
       restCallString = [restCallString stringByAppendingFormat:@"http://8tracks.com/sets/%@/skip.json?mix_id=%@&api_version=3&api_key=f3a1edd4dba9ad0679f06d846b58814df1a24122", playToken, mixId];
   }
   else
   {
       restCallString = [restCallString stringByAppendingFormat:@"http://8tracks.com/sets/%@/next_mix.json?mix_id=%@&api_version=3&api_key=f3a1edd4dba9ad0679f06d846b58814df1a24122", playToken, mixId];
   }
        NSLog(@"%@", restCallString);
    
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
        if ([[parsedObject valueForKey:@"status"] isEqualToString:@"403 Forbidden"])
            completion(@"notAllowed", NULL, NO);
        else
        {
            NSDictionary *set = [parsedObject valueForKey:@"set"];
            NSDictionary *track = [set valueForKey:@"track"];
            audioURL = [track valueForKey:@"track_file_stream_url"];
            completion(audioURL, [track valueForKey:@"id"],[set valueForKey:@"at_last_track"]);
        }
    }
    else{
        //check error domain and code
    }
    });
}


@end
