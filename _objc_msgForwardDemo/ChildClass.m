//
//  ChildClass.m
//  _objc_msgForwardDemo
//
//  Created by haorise on 2018/4/10.
//  Copyright © 2018年 haorise. All rights reserved.
//

#import "ChildClass.h"
#import "ForwardTarget.h"
#import <objc/runtime.h>

@interface ChildClass()

@property (nonatomic, strong) ForwardTarget *otherTarget;

@end

@implementation ChildClass

- (instancetype)init{
    if (self = [super init]) {
        _otherTarget = [[ForwardTarget alloc] init];
        [self performSelector:@selector(sel:) withObject:@"haha"];
    }
    return self;
}

id dynamicMethodIMP(id self, SEL _cmd, NSString *str)
{
    NSLog(@"%s:ChildClass动态添加的方法",__FUNCTION__);
    NSLog(@"%@", str);
    return @"1";
}



+ (BOOL)resolveInstanceMethod:(SEL)sel{
    // 第一次调用resolveInstanceMethod给个机会让类添加这个实现这个函数
//    class_addMethod(self.class, sel, (IMP)dynamicMethodIMP, "@@:");
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    // 第二次调用forwardingTargetForSelector让别的对象去执行这个函数
    id result = [super forwardingTargetForSelector:aSelector];
//    result = self.otherTarget;
    return result;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    // 第三次调用methodSignatureForSelector（函数符号制造器）和forwardInvocation（函数执行器）灵活的将目标函数以其他形式执行。
    id result = [super methodSignatureForSelector:aSelector];
    NSMethodSignature *sig = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    result = sig;
    return result;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
//    [super forwardInvocation:anInvocation]; 父类找到方法实现后不会继续往下执行
    anInvocation.selector = @selector(invocationTest);
    [self.otherTarget forwardInvocation:anInvocation];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    [super doesNotRecognizeSelector:aSelector];
}

@end
