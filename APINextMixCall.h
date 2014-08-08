//
//  APINextMixCall.h
//  APICallTest
//
//  Created by mac mini on 08/08/14.
//  Copyright (c) 2014 ___Papapapapow___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APINextMixCall : NSObject

+ (void) getNextMix:(NSString *)URL completion:(void(^)(NSString *))completion;

@end
