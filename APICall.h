//
//  APICall.h
//  APICallTest
//
//  Created by mac mini on 04/08/14.
//  Copyright (c) 2014 ___Papapapapow___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICallAudioUrl.h"

@interface APICall : NSObject
{
    NSURLConnection *currentConnection;
    NSString *playToken;
}


- (id) init;

- (void) getPlayToken;

-(NSString *) playToken;

@property (retain, nonatomic) NSMutableData *apiPlayReturn;

@end
