//
//  ThrowingClass.h
//  KLBaseKitTests
//
//  Created by Markus Troßbach on 23.11.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThrowingClass : NSObject

- (void)throwException;
- (void)noThrowException;

@end

NS_ASSUME_NONNULL_END
