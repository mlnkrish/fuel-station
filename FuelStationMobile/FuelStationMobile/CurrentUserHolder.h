//
// Created by MLN on 13/02/14.
// Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CurrentUserHolder : NSObject

+ (NSString *) getName;
+ (void) setName:(NSString *)name;
+ (NSString *) getToken;
+ (void) setToken:(NSString *)token;
+ (NSString *) getFuel;
+ (void) setFuel:(NSString *)token;

@end