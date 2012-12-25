//
//  KeyboardBar.h
//  firstSteps
//
//  Created by Vesela Popova on 13.08.12.
//
//

#import <UIKit/UIKit.h>

@interface KeyboardBar : UIToolbar
{
    long tag;
}

@property (nonatomic, retain) UITextField *field;
@property (nonatomic, retain) NSMutableArray * fields;
@property NSSet *lineIndexes;
@property int index;
@end
