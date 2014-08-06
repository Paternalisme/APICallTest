//
//  APITagCall.m
//  APICallTest
//
//  Created by mac mini on 06/08/14.
//  Copyright (c) 2014 ___Papapapapow___. All rights reserved.
//

#import "APITagCall.h"

@implementation APITagCall

- (id) initWithURL:(NSString *)URL
{
    self = [super init];

    
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
  
        NSDictionary *mix = [parsedObject valueForKey:@"mix_set"];
        
        NSArray *mixes = [mix valueForKey:@"mixes"];
        mixId = [mixes[0] valueForKey:@"id"];
        
        
        NSDictionary *tagCloud = [mix valueForKey:@"tag_cloud"];
        tags = [tagCloud valueForKey:@"tags"];
        
    }
    else{
        //check error domain and code
    }
    
    return self;
}

- (NSString *) mixId
{
    return mixId;
}

- (NSArray *) tags
{
    return tags;
}

@end
