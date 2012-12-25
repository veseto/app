//
//  MainView.h
//  Common
//
//  Created by Vesela Popova on 04.12.12.
//  Copyright (c) 2012 г. Vesela Popova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDown.h"

@interface MainView : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *veselaPaid;
@property (strong, nonatomic) IBOutlet UITextField *denizPaid;
@property (strong, nonatomic) IBOutlet DropDown *dropDown;
@property (strong, nonatomic) IBOutlet UITextView *text;
- (IBAction)calculate:(id)sender;
- (IBAction)reset:(id)sender;

@end
