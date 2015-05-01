//
//  AddMedicineViewController.m
//  My Meds Plan
//
//  Created by Felix Olivares on 4/30/15.
//  Copyright (c) 2015 Felix Olivares. All rights reserved.
//

#import "AddMedicineViewController.h"
#import "ActionSheetStringPicker.h"

@interface AddMedicineViewController ()

@end

@implementation AddMedicineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 101 || textField.tag == 102 || textField.tag == 103) {
        return NO;
    }else{
        return YES;
    }
}

- (IBAction)medicineEvery:(id)sender {
    NSArray *colors = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12",  nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select how many hours"
                                            rows:colors
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@", picker);
                                           NSLog(@"Selected Index: %ld", (long)selectedIndex);
                                           NSLog(@"Selected Value: %@", selectedValue);
                                           self.textFieldMedicineEvery.text = selectedValue; 
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}
- (IBAction)unitsPerDose:(id)sender {
    NSArray *colors = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select how many units"
                                            rows:colors
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@", picker);
                                           NSLog(@"Selected Index: %ld", (long)selectedIndex);
                                           NSLog(@"Selected Value: %@", selectedValue);
                                           self.textFieldUnitsPerDose.text = selectedValue;
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}
- (IBAction)medicineKind:(id)sender {
    NSArray *colors = [NSArray arrayWithObjects:@"Pills", @"Dropplets", @"Tablets", @"Tea Spoons", @"Shots", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select what kind"
                                            rows:colors
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           NSLog(@"Picker: %@", picker);
                                           NSLog(@"Selected Index: %ld", (long)selectedIndex);
                                           NSLog(@"Selected Value: %@", selectedValue);
                                           self.textFieldMedicineKind.text = selectedValue;
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}
@end
