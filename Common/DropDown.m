//
//  DropDown.m
//  DiabloIIIApp
//
//  Created by Vesela Popova on 31.10.12.
//  Copyright (c) 2012 г. Vesela Popova. All rights reserved.
//

#import "DropDown.h"
#import "PopoverView.h"

@implementation DropDown
@synthesize delegate = _delegate;
@synthesize button;
@synthesize text;

NSMutableArray *stringArray;

- (id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        tap.cancelsTouchesInView = NO; 
        [self addGestureRecognizer:tap];
        
        self.userInteractionEnabled = YES;
        
        text = [[UITextField alloc]  initWithFrame:CGRectMake(0, 0, 100, 25)];
        [text setEnabled:NO];
        
      //  [text setBackground:[UIImage imageNamed:@"images.jpeg"]];
        [text setBorderStyle:UITextBorderStyleLine];
        [text addTarget:self action:@selector(selectItem) forControlEvents:UIControlEventValueChanged];
        [text setTextColor:[UIColor colorWithRed:(139.0f/225.0f) green:(69.0f/225.0f) blue:(19.0f/225.0f) alpha:1.0f]];
        [text setFont:[UIFont fontWithName:@"Gill Sans" size:18.0]];
        [text setTextAlignment:NSTextAlignmentCenter];

        [text setText:@"Select"];

        [self addSubview:text];
        
        button = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 40, 25)];
       // [button addTarget:self action:@selector(showPopOver) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"0271@2x rotated.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"images.jpeg"] forState:UIControlStateNormal];

        [self addSubview:button];
    }
    return self;
}


-(void) showPopOver {
    CGPoint point = CGPointMake(50, 25);
    [PopoverView showPopoverAtPoint:point inView:self withStringArray:stringArray delegate:self];

}

-(void) setStringArray:(NSMutableArray *)array {
    stringArray = array;
}

- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index {
    text.text = [stringArray objectAtIndex:index];
    if(_delegate && [_delegate respondsToSelector:@selector(dropDown:didSelectItem:)]) {
        [_delegate dropDown:self didSelectItem:text.text];
    }
    [popoverView dismiss];
}

-(NSString *)getString {
    return text.text;
}

-(void)setString:(NSString *)string {
    text.text = string;
}
- (void)tapped:(UITapGestureRecognizer *)tap {
    [self showPopOver];
}

@end
