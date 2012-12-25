//
//  Settings.m
//  Common
//
//  Created by Vesela Popova on 25.12.12.
//  Copyright (c) 2012 г. Vesela Popova. All rights reserved.
//

#import "Settings.h"
#import "DBConnector.h"

@interface Settings ()

@end

@implementation Settings
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetDebt:(id)sender {
    [connector saveDebt:0 :0 :0 :0];
}

- (IBAction)clearHistory:(id)sender {
    [connector deleteHistory];
}
@end
