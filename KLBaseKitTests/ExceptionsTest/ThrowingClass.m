//
//  ThrowingClass.m
//  KLBaseKitTests
//
//  Created by Markus Troßbach on 23.11.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

#import "ThrowingClass.h"

@implementation ThrowingClass

- (void)throwException {
    NSException *ex = [NSException exceptionWithName:@"name" reason:@"reason" userInfo:nil];
    @throw ex;
}

- (void)noThrowException {
    NSLog(@"do something here :D");
}

@end
