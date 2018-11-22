//
//  ObjC.h
//  KCoreKit
//
//  Created by Markus Troßbach on 16.02.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjC : NSObject
+ (BOOL)catchException:(void (^)(void))tryBlock error:(__autoreleasing NSError **)error;
@end
