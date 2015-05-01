//
//  AddMedicineViewController.h
//  My Meds Plan
//
//  Created by Felix Olivares on 4/30/15.
//  Copyright (c) 2015 Felix Olivares. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMedicineViewController : UIViewController <UITextFieldDelegate>
- (IBAction)medicineEvery:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMedicineEvery;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMedicineName;
- (IBAction)unitsPerDose:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUnitsPerDose;
- (IBAction)medicineKind:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMedicineKind;

@end
