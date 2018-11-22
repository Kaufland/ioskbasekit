//
//  ObjC.m
//  KCoreKit
//
//  Created by Markus Troßbach on 16.02.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

#import "ObjC.h"

@implementation ObjC
+ (BOOL)catchException:(void (^)(void))tryBlock error:(__autoreleasing NSError **)error {
    @try {
        if (tryBlock != NULL) {
            tryBlock();
        }
        return YES;
    }
    @catch (NSException *exception) {
        *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:exception.userInfo];
        return NO;
    }
}
@end
