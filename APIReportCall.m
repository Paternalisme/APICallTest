//
//  APIReportCall.m
//  APICallTest
//
//  Created by mac mini on 07/08/14.
//  Copyright (c) 2014 ___Papapapapow___. All rights reserved.
//

#import "APIReportCall.h"

@implementation APIReportCall

+ (void) makeReportCall:(NSString *)URL
{
    
    NSURL *restURL = [NSURL URLWithString:URL];
    NSURLRequest *restRequest = [NSURLRequest requestWithURL:restURL];
    
    NSURLResponse *apiPlayReturn2;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:restRequest returningResponse:&apiPlayReturn2 error:&error];
    if(data){
            }
    else{
        //check error domain and code
    }
    
}


@end
