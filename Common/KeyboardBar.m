//
//  KeyboardBar.m
//  firstSteps
//
//  Created by Vesela Popova on 13.08.12.
//
//

#import "KeyboardBar.h"


@implementation KeyboardBar
@synthesize field;
@synthesize fields = _fields;
@synthesize index = _index;
@synthesize lineIndexes = _lineIndexes;

UIBarButtonItem *previous;
UIBarButtonItem *next;
UIBarButtonItem *done;

-(void) setField:(UITextField *)selectedField {
    long currentField = _index;
    field = selectedField;
    if (_index < 0 && _index >= _fields.count) {
        currentField = [_fields indexOfObject:field];
    }
    if (currentField == 0) {
        [previous setEnabled:NO];
        [next setEnabled:YES];
    } else if (currentField == [_fields count] - 1) {
        [next setEnabled:NO];
        [previous setEnabled:YES];
    } else {
        [next setEnabled:YES];
        [previous setEnabled:YES];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.barStyle = UIBarStyleDefault;
        [self sizeToFit];
        
        previous =[[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(didTapButtonBarItemPrevious:)];
        next =[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(didTapButtonBarItemNext:)];
        done =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTapButtonBarItemDone:)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        NSArray *array = [NSArray arrayWithObjects:previous, next, flexibleSpace, done, nil];
        [self setItems:array];
        long currentField = _index;
        if (_index < 0 && _index >= _fields.count) {
            currentField = [_fields indexOfObject:field];
        }
        if (currentField == 0) {
            [previous setEnabled:NO];
            [next setEnabled:YES];
        } else if (currentField == [_fields count] - 1) {
            [next setEnabled:NO];
            [previous setEnabled:YES];
        } else {
            [next setEnabled:YES];
            [previous setEnabled:YES];
        }
    }
        
    return self;
}

- (IBAction)didTapButtonBarItemPrevious:(UIButton *)sender{
    long currentField = _index;
    if (_index < 0 && _index >= _fields.count) {
        currentField = [_fields indexOfObject:field];
    }
    NSLog(@"previous current: %ld", currentField);
    if (currentField > 0) {
        UIResponder* nextResponder = [_fields objectAtIndex: currentField - 1];
        [self.field resignFirstResponder];
        [nextResponder becomeFirstResponder];
        [self setField:(UITextField *)[_fields objectAtIndex: currentField - 1]];
    }
    

}

- (void)didTapButtonBarItemNext:(UIButton *)sender{
    long currentField = _index;
    if (_index < 0 && _index >= _fields.count) {
        currentField = [_fields indexOfObject:field];
    }
    NSLog(@"next current: %ld", currentField);
    if (currentField < [_fields count] - 1) {
        UIResponder* nextResponder = [_fields objectAtIndex: currentField + 1];
        [self.field resignFirstResponder];
        [nextResponder becomeFirstResponder];
        [self setField:(UITextField *) [_fields objectAtIndex: currentField + 1]];
    }
}

- (void)didTapButtonBarItemDone:(UIButton *)sender{
    UITextField *tmp = self.field;
    self.field = nil;
    self.index = -1;
    [tmp resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
