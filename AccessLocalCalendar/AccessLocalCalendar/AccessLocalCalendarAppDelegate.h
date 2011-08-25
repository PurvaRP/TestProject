//
//  AccessLocalCalendarAppDelegate.h
//  AccessLocalCalendar
//
//  Created by MAC21 on 05/08/11.
//  Copyright 2011 diaspark India. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccessLocalCalendarViewController;

@interface AccessLocalCalendarAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet AccessLocalCalendarViewController *viewController;

@end
