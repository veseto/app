//
//  DropDown.h
//  DiabloIIIApp
//
//  Created by Vesela Popova on 31.10.12.
//  Copyright (c) 2012 г. Vesela Popova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverView.h"

@class DropDown;

@protocol DropDownDelegate <NSObject>

@optional

//Delegate receives this call as soon as the item has been selected
- (void)dropDown:(DropDown *)dropDown didSelectItem:(NSString *)item;

@end

@interface DropDown : UIView <PopoverViewDelegate>

@property UITextField * text;
@property UIButton *button;

@property (nonatomic, assign) id<DropDownDelegate> delegate;

-(void) setStringArray: (NSMutableArray *) array;
-(NSString *) getString;
-(void) setString: (NSString *) string;

@end
