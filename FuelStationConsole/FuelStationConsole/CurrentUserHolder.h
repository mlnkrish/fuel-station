//
// Created by MLN on 13/02/14.
// Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CurrentUserHolder : NSObject

+ (NSString *) getName;
+ (void) setName:(NSString *)name;
+ (NSNumber *) getToken;
+ (void) setToken:(NSNumber *)token;

@end