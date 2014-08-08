//
//  APINextMixCall.m
//  APICallTest
//
//  Created by mac mini on 08/08/14.
//  Copyright (c) 2014 ___Papapapapow___. All rights reserved.
//

#import "APINextMixCall.h"

@implementation APINextMixCall

+ (void) getNextMix:(NSString *)URL completion:(void(^)(NSString *))completion
{
    NSURL *restURL = [NSURL URLWithString:URL];
    NSURLRequest *restRequest = [NSURLRequest requestWithURL:restURL];
    
    NSURLResponse *apiPlayReturn2;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:restRequest returningResponse:&apiPlayReturn2 error:&error];
    if(data){
        NSError *localError = nil;
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&localError];
        if (localError)
            NSLog(@"JSONObjectWithData error: %@", localError);
        
        NSDictionary *mix = [parsedObject valueForKey:@"next_mix"];
        

        completion([mix valueForKey:@"id"]);
        
    }
    else{
        //check error domain and code
    }
    
}

@end
