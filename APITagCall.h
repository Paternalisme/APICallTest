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
    NSArray *tagsList;
}

+ (id)initWithURL:(NSString *)URL completion:(void(^)(NSString *, NSArray *, NSArray *, NSDictionary *))completion;
- (NSArray *) tags;
- (NSString *) mixId;

@end
