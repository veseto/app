//
//  MainView.m
//  Common
//
//  Created by Vesela Popova on 04.12.12.
//  Copyright (c) 2012 г. Vesela Popova. All rights reserved.
//

#import "MainView.h"
#import "AppDelegate.h"
#import "DBConnector.h"
#import "KeyboardBar.h"

@interface MainView ()

@end

@implementation MainView
DBConnector * connector;
KeyboardBar *bar;


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
    bar = [[KeyboardBar alloc] init];
    [[bar fields] addObject:[self veselaPaid]];
    [[bar fields] addObject:[self denizPaid]];
    [self veselaPaid].inputAccessoryView = bar;
    [self denizPaid].inputAccessoryView = bar;
}

- (void)viewWillAppear:(BOOL)animated {
    NSMutableArray * currencies = [NSMutableArray arrayWithObjects: @"BGN", @"EUR", @"USD", @"Vouchers", nil];
    [[self dropDown] setStringArray:currencies];
    [[self dropDown] setString:@"BGN"];
    
    connector = [[DBConnector alloc] init];
    NSManagedObject *matches = [connector getDebt];
    if (matches != nil) {
        float bgn = [[matches valueForKey:@"bgn"] floatValue];
        float eur = [[matches valueForKey:@"eur"] floatValue];
        float usd = [[matches valueForKey:@"usd"] floatValue];
        float vouchers = [[matches valueForKey:@"vouchers"] floatValue];
        NSString *text = @"";
        
        if (bgn > 0) {
            text = [text stringByAppendingString:[NSString stringWithFormat:@"Весела дължи: %.02f лв.\n", bgn]];
        }else if (bgn < 0) {
            text = [text stringByAppendingString:[NSString stringWithFormat:@"Дениз дължи %.02f лв.\n", -bgn]];
        }
        if (eur > 0) {
            text = [text stringByAppendingString:[NSString stringWithFormat:@"Весела дължи: %.02f EUR.\n", eur]];
        }else if (eur < 0) {
            text = [text stringByAppendingString:[NSString stringWithFormat:@"Дениз дължи %.02f EUR.\n", -eur]];
        }
        if (usd > 0) {
            text = [text stringByAppendingString:[NSString stringWithFormat:@"Весела дължи: %.02f $.\n", usd]];
        }else if (usd < 0) {
            text = text =[text stringByAppendingString:[NSString stringWithFormat:@"Дениз дължи %.02f $.\n", -usd]];
        }
        if (vouchers > 0) {
            text = [text stringByAppendingString:[NSString stringWithFormat:@"Весела дължи: %.02f ваучери.\n", vouchers]];
        }else if (vouchers < 0) {
            text = [text stringByAppendingString:[NSString stringWithFormat:@"Дениз дължи %.02f ваучери.\n", -vouchers]];
        }
        [self text].text = text;
    }else {
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculate:(id)sender {
    [self.veselaPaid resignFirstResponder];
    [self.denizPaid resignFirstResponder];
    
    float vesela = [self.veselaPaid.text floatValue];
    float deniz = [self.denizPaid.text floatValue];
    
    [connector saveHistory:[NSDate date] :vesela :deniz :self.dropDown.getString];
    float total = vesela + deniz;
    vesela = total/2 - vesela;
    deniz = total/2 - deniz;
    
    NSManagedObject *matches = [connector getDebt];
    float bgn = [[matches valueForKey:@"bgn"] floatValue];
    float eur = [[matches valueForKey:@"eur"] floatValue];
    float usd = [[matches valueForKey:@"usd"] floatValue];
    float vouchers = [[matches valueForKey:@"vouchers"] floatValue];
    if (matches == nil) {
       
    } else {
        if ([self.dropDown.getString isEqualToString:@"USD"]) {
            usd = [[matches valueForKey:@"usd"] floatValue] + vesela;
        } else if ([self.dropDown.getString isEqualToString:@"EUR"]) {
            eur = [[matches valueForKey:@"eur"] floatValue] + vesela;
        } else if ([self.dropDown.getString isEqualToString:@"BGN"]) {
            bgn = [[matches valueForKey:@"bgn"] floatValue] + vesela;
        } else if ([self.dropDown.getString isEqualToString:@"Vouchers"]) {
            vouchers = [[matches valueForKey:@"vouchers"] floatValue] + vesela;
        }
        
    }
    [connector saveDebt:bgn :usd :eur :vouchers];
    matches = [connector getDebt];
    bgn = [[matches valueForKey:@"bgn"] floatValue];
    eur = [[matches valueForKey:@"eur"] floatValue];
    usd = [[matches valueForKey:@"usd"] floatValue];
    vouchers = [[matches valueForKey:@"vouchers"] floatValue];
    NSString *text = [[NSString alloc] init];
    
    if (bgn > 0) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Весела дължи: %.02f лв.\n", bgn]];
    }else if (bgn < 0) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Дениз дължи %.02f лв.\n", -bgn]];
    }
    if (eur > 0) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Весела дължи: %.02f EUR.\n", eur]];
    }else if (eur < 0) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Дениз дължи %.02f EUR.\n", -eur]];
    }
    if (usd > 0) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Весела дължи: %.02f $.\n", usd]];
    }else if (usd < 0) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Дениз дължи %.02f $.\n", -usd]];
    }
    if (vouchers > 0) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Весела дължи: %.02f ваучери.\n", vouchers]];
    }else if (vouchers < 0) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"Дениз дължи %.02f ваучери.\n", -vouchers]];
    }
    [self text].text = text;
}

- (IBAction)reset:(id)sender {
    
    [connector saveDebt:0 :0: 0: 0];
    self.text.text = @"";
}
@end
