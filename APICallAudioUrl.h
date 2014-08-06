//
//  APICallAudioUrl.h
//  APICallTest
//
//  Created by mac mini on 05/08/14.
//  Copyright (c) 2014 ___Papapapapow___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APICallAudioUrl : NSObject
{
    NSURLConnection *currentConnection;
    NSString *audioURL;
}

- (id) init;

- (void) getAudioURL:(NSString *)mixId :(NSString *)playToken;

-(NSString *) audioURL;

@end
