//
//  CategoryPickerViewController.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "CategoryPickerViewController.h"
#import "KeepLayout.h"
#import <Realm/Realm.h>
#import "Category.h"

@interface CategoryPickerViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView *categoryPicker;
@property (nonatomic) RLMResults<Category *> *category;
@end

@implementation CategoryPickerViewController

- (void)loadView
{
    [super loadView];
    UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2)];
    picker.backgroundColor = [UIColor lightGrayColor];
    picker.delegate = self;
    picker.dataSource = self;
    [self.view addSubview:picker];
    self.categoryPicker = picker;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.category = [Category allObjects];
    // Default seleted
    Category *select = self.category[0];
    self.callback(select);
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.category.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.category[row].name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.callback) {
        Category *select = self.category[row];
        self.callback(select);
    }
}
@end
