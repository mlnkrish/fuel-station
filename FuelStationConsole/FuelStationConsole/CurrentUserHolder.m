//
// Created by MLN on 13/02/14.
// Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "CurrentUserHolder.h"


@implementation CurrentUserHolder

static NSString *userName;
static NSString *userToken;

+ (NSString *) getName {
    return userName;
}

+(void) setName:(NSString *)name {
    userName = name;
}

+ (NSString *) getToken {
    return userToken;
}

+(void) setToken:(NSNumber *)token {
    userToken = token;
}

@end