//
//  AccessLocalCalendarViewController.m
//  AccessLocalCalendar
//
//  Created by MAC21 on 05/08/11.
//  Copyright 2011 diaspark India. All rights reserved.
//

#import "AccessLocalCalendarViewController.h"

@interface AccessLocalCalendarViewController()
- (void)getEventsOfMonth;
@end



@implementation AccessLocalCalendarViewController
@synthesize managedObjectContext;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;

- (void)dealloc {
    if(eventStore) {
        [eventStore release];
        eventStore = nil;
    }
    
    if(eventArray) {
        [eventArray removeAllObjects];
        [eventArray release];
        eventArray = nil;
    }
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    eventStore = [[EKEventStore alloc] init];
    [self getEventsOfMonth];
//    NSManagedObject *newEmployee = [NSEntityDescription
//                                    insertNewObjectForEntityForName:@"Table2"
//                                    inManagedObjectContext:managedObjectContext];
} 

#pragma mark - Private methods 
- (void) getEventsOfMonth {
    // Create the predicate's start and end dates.
    CFGregorianDate gregorianStartDate, gregorianEndDate;
    CFGregorianUnits startUnits = {0, 0, -10, 0, 0, 0};
    CFGregorianUnits endUnits = {0, 0, 0, 0, 0, 0};
    CFTimeZoneRef timeZone = CFTimeZoneCopySystem();
    
    gregorianStartDate = CFAbsoluteTimeGetGregorianDate(
                                                        CFAbsoluteTimeAddGregorianUnits(CFAbsoluteTimeGetCurrent(), timeZone, startUnits),
                                                        timeZone);
    gregorianStartDate.hour = 0;
    gregorianStartDate.minute = 0;
    gregorianStartDate.second = 0;
    
    gregorianEndDate = CFAbsoluteTimeGetGregorianDate(
                                                      CFAbsoluteTimeAddGregorianUnits(CFAbsoluteTimeGetCurrent(), timeZone, endUnits),
                                                      timeZone);
    gregorianEndDate.hour = 0;
    gregorianEndDate.minute = 0;
    gregorianEndDate.second = 0;
    
    
    NSDate* startDate = [NSDate dateWithTimeIntervalSinceReferenceDate:CFGregorianDateGetAbsoluteTime(gregorianStartDate, timeZone)];
    
    NSDate* endDate = [NSDate dateWithTimeIntervalSinceReferenceDate:CFGregorianDateGetAbsoluteTime(gregorianEndDate, timeZone)];
    CFRelease(timeZone);
   
    // Create the predicate.
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil]; // eventStore is an instance variable.
 
    // Fetch all events that match the predicate.
    NSArray *events = [eventStore eventsMatchingPredicate:predicate];
    eventArray = [NSMutableArray arrayWithArray:events];
    NSLog(@"event array:%@, total events:%d", eventArray, [eventArray count]);
    //EKEvent *obj = [eventArray objectAtIndex:0];
    [eventArray sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];
    //NSLog(@"event arraey sorted:%@",eventArray);
    
    NSLog(@"calendars :%@",[eventStore calendars]);
    NSLog(@"def calendar:%@",[eventStore defaultCalendarForNewEvents]);
}


@end
