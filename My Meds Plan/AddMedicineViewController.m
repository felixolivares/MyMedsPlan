//
//  AddMedicineViewController.m
//  My Meds Plan
//
//  Created by Felix Olivares on 4/30/15.
//  Copyright (c) 2015 Felix Olivares. All rights reserved.
//

#import "AddMedicineViewController.h"
#import "ActionSheetStringPicker.h"
#import "Plan.h"
#import "AppDelegate.h"
#import "MPColorTools.h"
#import "UINavigationBar+Addition.h"
#import "BButton.h"

@interface AddMedicineViewController (){
    BOOL isEditing;
    BOOL showOtherUser;
}

@end

@implementation AddMedicineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backgroundView.backgroundColor = [UIColor colorWithRGB:0x4CAAA0];
    self.containerView.backgroundColor = [UIColor whiteColor]; 
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar makeTransparent];
    
    CGFloat borderWidth = 1.0f;
    
    self.containerView.frame = CGRectInset(self.containerView.frame, -borderWidth, -borderWidth);
    self.containerView.layer.borderColor = [UIColor colorWithRGB:0xC8C5CB].CGColor;
    self.containerView.layer.borderWidth = borderWidth;
    
    [self.saveBtn addAwesomeIcon:FACheck beforeTitle:NO];
    [self.backBtn addAwesomeIcon:FAArrowLeft beforeTitle:YES];
    
    showOtherUser = NO;
    self.otherUserContainer.alpha = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    if ([self.medicineNameString length] > 0) {
        isEditing = YES;
        NSLog(@"string received : %@", self.medicineNameString);
        self.plan = [Plan MR_findFirstByAttribute:@"medicationName" withValue:self.medicineNameString];
        self.textFieldMedicineName.text = self.plan.medicationName;
        self.textFieldMedicineKind.text = self.plan.medicineKind;
        self.textFieldMedicineEvery.text = [NSString stringWithFormat:@"%@", self.plan.periodicity];
        self.textFieldUnitsPerDose.text = [NSString stringWithFormat:@"%@", self.plan.unitsPerDose];
        self.textViewComments.text = self.plan.additionalInfo;
        
        if ([self.plan.otherUser length] > 0) {
            self.otherUserNameField.text = self.plan.otherUser;
            showOtherUser = YES;
            [self.bottomConstraintOtherUserBtn setConstant:130];
            self.otherUserContainer.alpha = 1; 
        }
        
        [self hideLabels:1.0];
    }else{
        NSLog(@"new register");
        isEditing = NO;
        [self hideLabels:0]; 
    }
}

-(void)hideLabels:(CGFloat)alphaValue{
    self.nameLabel.alpha = alphaValue;
    self.takeLabel.alpha = alphaValue;
    self.unitsLabel.alpha = alphaValue;
    self.kindLabel.alpha = alphaValue;
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
    NSArray *hours = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12",@"24", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select how many hours"
                                            rows:hours
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
    NSArray *dose = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"10", @"15", @"20", @"30", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select how many units"
                                            rows:dose
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
- (IBAction)saveButton:(id)sender {
    if (!self.plan) {
        self.plan = [Plan MR_createEntity];
    }
    
    self.plan.medicationName = self.textFieldMedicineName.text;
    self.plan.medicineKind = self.textFieldMedicineKind.text;
    self.plan.periodicity = [NSNumber numberWithInteger:[self.textFieldMedicineEvery.text integerValue]];
    self.plan.unitsPerDose = [NSNumber numberWithInteger:[self.textFieldUnitsPerDose.text integerValue]];
    self.plan.additionalInfo = self.textViewComments.text;
    [self saveContext];
}

- (void)saveContext {
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
            [self.navigationController popViewControllerAnimated:YES];
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveBtn:(id)sender {
    if (!self.plan) {
        self.plan = [Plan MR_createEntity];
    }
    
    self.plan.medicationName = self.textFieldMedicineName.text;
    self.plan.medicineKind = self.textFieldMedicineKind.text;
    self.plan.periodicity = [NSNumber numberWithInteger:[self.textFieldMedicineEvery.text integerValue]];
    self.plan.unitsPerDose = [NSNumber numberWithInteger:[self.textFieldUnitsPerDose.text integerValue]];
    self.plan.additionalInfo = self.textViewComments.text;
    self.plan.otherUser = self.otherUserNameField.text; 
    [self saveContext];
}
- (IBAction)otherUserBtn:(id)sender {
    if (showOtherUser) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.bottomConstraintOtherUserBtn setConstant:20];
            self.otherUserContainer.alpha = 0;
            [self.view layoutIfNeeded];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [self.bottomConstraintOtherUserBtn setConstant:130];
            self.otherUserContainer.alpha = 1;
            [self.view layoutIfNeeded];
        }];
    }
    showOtherUser = !showOtherUser; 
}
@end
