//
//  DBConnector.m
//  Common
//
//  Created by Vesela Popova on 15.12.12.
//  Copyright (c) 2012 г. Vesela Popova. All rights reserved.
//

#import "DBConnector.h"
#import "AppDelegate.h"
@implementation DBConnector


-(NSObject *) getDebt {
    AppDelegate *delegate =[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Bills" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    NSManagedObject *settings;
    if ([objects count] == 0) {
        return nil;
    } else {
        return settings = [objects objectAtIndex:0];
    }
}

-(void) saveDebt:(float) bgn: (float) usd: (float) eur: (float) vouchers {
    AppDelegate *delegate =[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Bills" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    NSManagedObject *settings;
    if ([objects count] == 0) {
        settings = [NSEntityDescription insertNewObjectForEntityForName:@"Bills"
                                                 inManagedObjectContext:context];
    } else {
        settings = [objects objectAtIndex:0];
    }
    [settings setValue:[NSNumber numberWithFloat:bgn] forKey:@"bgn"];
    [settings setValue:[NSNumber numberWithFloat:usd] forKey:@"usd"];
    [settings setValue:[NSNumber numberWithFloat:eur] forKey:@"eur"];
    [settings setValue:[NSNumber numberWithFloat:vouchers] forKey:@"vouchers"];

    [context save:&error];
}

-(NSMutableArray *) getHistory {
    AppDelegate *delegate =[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"History" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSError *error;
    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:request error:&error]];
    return objects;
}

-(void) saveHistory: (NSDate *) date: (float) vesela: (float) deniz: (NSString *) currency{
    if (vesela != 0 || deniz != 0) {
        AppDelegate *delegate =[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [delegate managedObjectContext];
        NSError *error;
        NSManagedObject *settings;
        settings = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:context];
        [settings setValue:date forKey:@"date"];
        [settings setValue:[NSNumber numberWithDouble:vesela] forKey:@"vesela"];
        [settings setValue:[NSNumber numberWithDouble:deniz] forKey:@"deniz"];
        [settings setValue:currency forKey:@"currency"];
        
        [context save:&error];
        if (error != nil) {
            NSLog(@"");
        }
    }
}

-(void) deleteHistory {
    AppDelegate *delegate =[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"History" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSError *error;
    NSMutableArray *objects = [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:request error:&error]];
    for (NSManagedObject * obj in objects) {
        [context deleteObject:obj];
    }
    [context save:&error];
}



@end
