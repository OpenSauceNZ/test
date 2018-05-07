//
//  RecordViewCell.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "RecordViewCell.h"
#import "KeepLayout.h"

@implementation RecordViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UILabel *title = [[UILabel alloc] init];
    title.textColor = [UIColor blackColor];
    [self.contentView addSubview:title];
    title.keepLeadingInset.equal = 16;
    title.keepTopInset.equal = 0;
    title.keepHeight.equal = 50;
    self.title = title;
    
    UILabel *subTitle = [[UILabel alloc] init];
    subTitle.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:subTitle];
    subTitle.keepLeadingInset.equal = 16;
    subTitle.keepTopOffsetTo(title).equal = 0;
    subTitle.keepBottomInset.equal = 5;
    self.subTitle = subTitle;
    
    UILabel *amount = [[UILabel alloc] init];
    amount.textColor = [UIColor blackColor];
    amount.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:amount];
    amount.keepHorizontalAlignTo(title).equal = 0;
    amount.keepTrailingInset.equal = 16;
    amount.keepLeadingOffsetTo(title).equal = 0;
    self.amount = amount;
    
    UILabel *currency = [[UILabel alloc] init];
    currency.textColor = [UIColor blackColor];
    currency.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:currency];
    currency.keepHorizontalAlignTo(subTitle).equal = 0;
    currency.keepTrailingInset.equal = 16;
    currency.keepWidth.equal = 50;
    self.currency = currency;
}
@end
