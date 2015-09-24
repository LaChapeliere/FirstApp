//
//  CPPFile.cpp
//  FirstApp
//
//  Created by Emma Barme on 21/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

#include "CPPFile.h"


int Useless::waitingFunc(int input) {
    std::this_thread::sleep_for (std::chrono::seconds(5));
    return input + 1;
}

int Useless::doStuffLib(int input) {
    return doStuff(input);
}