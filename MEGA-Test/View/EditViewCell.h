//
//  EditViewCell.h
//  MEGA-Test
//
//  Created by Liguo Jiao on 8/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kEditTableCellId @"EditTableCell"
#define kEditAmountCellId @"EditAmountCell"
#define kEditCategoryCellId @"EditCategoryCell"
#define kEditSegmentTableCellId @"EditSegmentTableCell"

@interface EditViewCell : UITableViewCell <UITextFieldDelegate>
@property (nonatomic) UILabel *title;
@property (nonatomic) UITextField *contentField;
@property (nonatomic) UISegmentedControl *currencySegment;
@property (nonatomic) UIPickerView *dataPicker;
@end
