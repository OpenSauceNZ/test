//
//  EditViewCell.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 8/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "EditViewCell.h"
#import "KeepLayout.h"

@implementation EditViewCell
{
    NSString *cellIdentifier;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        UILabel *title = [[UILabel alloc] init];
        [self.contentView addSubview:title];
        [title keepVerticallyCentered];
        title.keepLeadingInset.equal = 16;
        title.keepWidth.equal = 80;
        self.title = title;
        cellIdentifier = reuseIdentifier;
        
        if ([reuseIdentifier isEqual:kEditSegmentTableCellId])
        {
            [self segmentSetup];
        }
        else
        {
            [self generalSetup];
            if ([reuseIdentifier isEqual:kEditCategoryCellId])
            {
                self.contentField.tintColor = [UIColor clearColor];
                self.contentField.inputView = [[UIView alloc] init];
            }
            if ([reuseIdentifier isEqual:kEditAmountCellId])
            {
                self.contentField.keyboardType = UIKeyboardTypeNumberPad;
                self.contentField.delegate = self;
            }
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)generalSetup
{
    UITextField *field = [[UITextField alloc] init];
    field.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:field];
    [field keepVerticallyCentered];
    field.keepTrailingInset.equal = 16;
    field.keepLeadingOffsetTo(self.title).equal = 20;
    self.contentField = field;
}

- (void)segmentSetup
{
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"NZD", @"USD"]];
    segment.selectedSegmentIndex = 0;
    [self.contentView addSubview:segment];
    [segment keepVerticallyCentered];
    segment.keepTrailingInset.equal = 16;
    segment.keepLeadingOffsetTo(self.title).equal = 50;
    self.currencySegment = segment;
}

#pragma mark - UITextfield Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([cellIdentifier isEqual:kEditAmountCellId])
    {
        if (!string.length)
        {
            return YES;
        }
        if ([string intValue])
        {
            return YES;
        }
        return NO;
    }
    else
    {
        return YES;
    }
}

@end
