//
//  main.m
//  MoreLoad
//
//  Created by pencilCool on 2020/7/21.
//  Copyright © 2020 pencilCool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MoreOCLoadClass.hpp"
@import ObjectiveC;

@interface Pole : NSObject

@end

@implementation Pole
+ (void)load {
    NSLog(@"Pole");
}
@end

static void addMoreLoad(void) {
    for (NSInteger i = 0; i < 2; i ++) {
        NSString *className = [NSString stringWithFormat:@"PencilCoolClass%ld",i];
        Class aClass = objc_allocateClassPair(NSObject.class, className.UTF8String, 0);
        Method originalMethod = class_getClassMethod(Pole.class, @selector(load));
        IMP method = [Pole methodForSelector:@selector(load)];
        class_addMethod(aClass, @selector(load), method, method_getTypeEncoding(originalMethod));
        objc_registerClassPair(aClass);
    }
    
}

__attribute__((constructor))
static void beforeMain(void) {
    NSLog(@"beforeMain");
    addMoreLoad();
}

__attribute__((destructor))
static void afterMain(void) {
    NSLog(@"afterMain");
}


int main(int argc, char * argv[]) {
    NSLog(@"in Main");
    NSString * appDelegateClassName;
    @autoreleasepool {
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}


