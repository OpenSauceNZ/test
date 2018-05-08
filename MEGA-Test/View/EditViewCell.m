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
    [self.contentView addSubview:title];
    [title keepVerticallyCentered];
    title.keepLeadingInset.equal = 16;
    title.keepWidth.equal = 80;
    self.title = title;
    
    UITextField *field = [[UITextField alloc] init];
    field.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:field];
    [field keepVerticallyCentered];
    field.keepTrailingInset.equal = 16;
    field.keepLeadingOffsetTo(title).equal = 20;
    self.contentField = field;
    
}

@end
