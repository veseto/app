//
//  HistoryView.m
//  Common
//
//  Created by Vesela Popova on 17.12.12.
//  Copyright (c) 2012 г. Vesela Popova. All rights reserved.
//

#import "HistoryView.h"
#import "DBConnector.h"

@interface HistoryView ()

@end

@implementation HistoryView
@synthesize tableView = _tableView;

NSArray *history;
DBConnector *connector;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    connector = [[DBConnector alloc] init];
    history = [[NSArray alloc] initWithArray:[connector getHistory]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    history = [[NSArray alloc] initWithArray:[connector getHistory]];
    [_tableView reloadData]; 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [history count] - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HistoryRecord";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSManagedObject *current = [history objectAtIndex:indexPath.row];
    UILabel *date = (UILabel *)[cell viewWithTag:100];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSString* str = [formatter stringFromDate:[current valueForKey:@"date"]];
    date.text = str;
    
    NSNumberFormatter *num = [[NSNumberFormatter alloc] init];
    [num setNumberStyle:NSNumberFormatterNoStyle];
    
    UILabel *vesela = (UILabel *)[cell viewWithTag:200];
    vesela.text = [num stringFromNumber:[current valueForKey:@"vesela"]];
    UILabel *deniz = (UILabel *)[cell viewWithTag:300];
    deniz.text = [num stringFromNumber:[current valueForKey:@"deniz"]];
    UILabel *currency = (UILabel *)[cell viewWithTag:400];
    currency.text = [current valueForKey:@"currency"];
    return cell;
}

@end
