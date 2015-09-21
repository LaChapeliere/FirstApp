//
//  ObjCToCPP.m
//  FirstApp
//
//  Created by Emma Barme on 21/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

#import "ObjCToCPP.h"
#import "CPPFile.h"

@implementation Useless_ObjCtoCPlusPlus

+ (NSInteger) waitingFuncCPlusPlus: (NSInteger) input
{
    return (NSInteger) Useless::waitingFunc((int) input);
}
@end