//
//  AccessLocalCalendarViewController.h
//  AccessLocalCalendar
//
//  Created by MAC21 on 05/08/11.
//  Copyright 2011 diaspark India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <CoreData/CoreData.h>

@interface AccessLocalCalendarViewController : UIViewController {
    EKEventStore *eventStore;
    NSMutableArray *eventArray;
}
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
