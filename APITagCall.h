//
//  APITagCall.h
//  APICallTest
//
//  Created by mac mini on 06/08/14.
//  Copyright (c) 2014 ___Papapapapow___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APITagCall : NSObject
{
    NSString *mixId;
    NSArray *tags;
}

- (id)initWithURL:(NSString *)URL;
- (NSArray *) tags;
- (NSString *) mixId;

@end
