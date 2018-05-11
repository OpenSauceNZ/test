//
//  EditViewController.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "EditViewController.h"
#import "EditTableSource.h"
#import "EditViewCell.h"
#import "UIViewController+Modal.h"
#import "CategoryPickerViewController.h"

@interface EditViewController () <EditTableDelgate>
@property (nonatomic, strong) EditTableSource *datasource;
@end

@implementation EditViewController

- (void)loadView
{
    [super loadView];
    self.title = @"Edit";
    UIBarButtonItem *trailButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    UIBarButtonItem *leadButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = leadButton;
    self.navigationItem.rightBarButtonItem = trailButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak __typeof__(self) weakSelf = self;
    
    if (!self.transaction)
    {
        Transaction *record = [[Transaction alloc] init];
        self.transaction = record;
    }
    [self.tableView registerClass:[EditViewCell class] forCellReuseIdentifier:kEditTableCellId];
    [self.tableView registerClass:[EditViewCell class] forCellReuseIdentifier:kEditAmountCellId];
    [self.tableView registerClass:[EditViewCell class] forCellReuseIdentifier:kEditCategoryCellId];
    [self.tableView registerClass:[EditViewCell class] forCellReuseIdentifier:kEditSegmentTableCellId];
    [self fetchJSON];
    self.datasource = [[EditTableSource alloc] initDataSourceWithTransaction:self.transaction delegate:self];
    self.datasource.isAddNewRecord = self.isNewRecord;
    self.datasource.callback = ^(EditViewCell *cell) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(showCategoryPicker)];
        [cell.contentField addGestureRecognizer:tap];
    };
    [self.tableView setDelegate:self.datasource];
    [self.tableView setDataSource:self.datasource];
    [self.tableView reloadData];
}

- (void)save
{
    NSMutableArray<EditViewCell *> *content = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 6; i++)
    {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        EditViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
        [content addObject:cell];
    }
    if (content.count > 0)
    {
        RLMResults *result = [Transaction allObjects];
        BOOL completed = YES;
        NSNumber *maxID = [NSNumber numberWithInt:(int)[result maxOfProperty:@"transactionId"]];
        self.transaction.transactionId = [NSNumber numberWithInt:[maxID intValue] + 1];
        self.transaction.name = content[0].contentField.text;
        
        if (content[1].contentField.text.length > 0)
        {
            self.transaction.amount = [NSNumber numberWithInt:[content[1].contentField.text intValue]];
        }
        else
        {
            completed = NO;
            [self alertError:@"Error" message:@"Please enter the amount"];
        }
        
        if (self.datasource.selectCurrency.currencyId == [NSNumber numberWithInt:1])
        {
            float exchanged = [self.transaction.amount floatValue] * [self.exchange.nzdRate floatValue];
            self.transaction.displayAmount = [NSNumber numberWithFloat:exchanged];// TODO: get after calculated money
            
        }
        else
        {
            self.transaction.displayAmount = self.transaction.amount;
        }
        
        if (self.datasource.selectCurrency)
        {
            self.transaction.currency = self.datasource.selectCurrency;
        }
        else
        {
            completed = NO;
            [self alertError:@"Error" message:@"Please selete currency"];
        }

        if (self.datasource.seletedCategory)
        {
            self.transaction.category = self.datasource.seletedCategory;
        }
        else
        {
            completed = NO;
            [self alertError:@"Error" message:@"Haven't selete category"];
        }
        
        self.transaction.date = [NSDate date];
        self.transaction.note = content[5].contentField.text;
        
        Category *category = [Category objectForPrimaryKey:[NSNumber numberWithInt:0]];
        BOOL isVaildTransaction = ([category.budget intValue] - [self.transaction.displayAmount intValue]) > 0 && completed;
        
        if (isVaildTransaction)
        {
            [[RLMRealm defaultRealm] beginWriteTransaction];
            category.budget = [NSNumber numberWithInt:[category.budget intValue] - [self.transaction.displayAmount intValue]];
            [[RLMRealm defaultRealm] addOrUpdateObject:category];
            [[RLMRealm defaultRealm] addObject:self.transaction];
            [[RLMRealm defaultRealm] commitWriteTransaction];
            [self dismissViewControllerAnimated:YES completion:nil]; // TODO: after dismiss refresh Transaction page
        }
        else
        {
            [self alertError:@"Error" message:@"Beyound the category budget"];
        }
    }
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showCategoryPicker
{
    [self.tableView endEditing:YES];
    // show category picker
    CategoryPickerViewController *vc = [[CategoryPickerViewController alloc]init];
    vc.callback = ^(Category *selectedCategory) {
        self.datasource.seletedCategory = selectedCategory;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    };
    [self presentTransparentController:vc animated:NO];
}

@end
