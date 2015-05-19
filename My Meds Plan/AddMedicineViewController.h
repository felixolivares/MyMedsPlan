//
//  AddMedicineViewController.h
//  My Meds Plan
//
//  Created by Felix Olivares on 4/30/15.
//  Copyright (c) 2015 Felix Olivares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BButton.h"

@class Plan;

@interface AddMedicineViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) Plan *plan;
@property (nonatomic, strong) NSString *medicineNameString;

- (IBAction)medicineEvery:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMedicineEvery;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMedicineName;
- (IBAction)unitsPerDose:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUnitsPerDose;
- (IBAction)medicineKind:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMedicineKind;
- (IBAction)saveButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textViewComments;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *takeLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitsLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet BButton *saveBtn;
@property (weak, nonatomic) IBOutlet BButton *backBtn;
- (IBAction)backButton:(id)sender;
- (IBAction)saveBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *otherUserContainer;
- (IBAction)otherUserBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *otherUserBtnProperty;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOtherUserBtn;
@property (weak, nonatomic) IBOutlet UITextField *otherUserNameField;

@end
