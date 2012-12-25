//
//  DBConnector.h
//  Common
//
//  Created by Vesela Popova on 15.12.12.
//  Copyright (c) 2012 г. Vesela Popova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBConnector : NSObject

-(NSManagedObject *) getDebt;
-(void) saveDebt:(float) bgn: (float) usd: (float) eur: (float) vouchers;
-(NSMutableArray *) getHistory;
-(void) saveHistory: (NSDate *) date: (float) vesela: (float) deniz: (NSString *) currency;
-(void) deleteHistory;
@end
