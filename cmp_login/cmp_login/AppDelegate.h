//
//  AppDelegate.h
//  cmp_login
//
//  Created by Vincenzo on 17/10/13.
//  Copyright (c) 2013 Vincenzo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cmp_login_view.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    cmp_login_view *viewController;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)cmp_login_view *viewController;

@end
