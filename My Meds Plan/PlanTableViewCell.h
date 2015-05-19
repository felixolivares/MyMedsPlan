//
//  PlanTableViewCell.h
//  My Meds Plan
//
//  Created by Felix Olivares on 5/4/15.
//  Copyright (c) 2015 Felix Olivares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BButton.h"
#import "ZGCountDownTimer.h"
#import "Plan.h"


@interface PlanTableViewCell : UITableViewCell <UIAlertViewDelegate>

@property (strong, nonatomic) Plan *plan;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *doseLabel;
@property (strong, nonatomic) IBOutlet UILabel *counter;
@property (strong, nonatomic) IBOutlet UILabel *fireDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *additionalInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet BButton *btn;
@property (strong, nonatomic) IBOutlet BButton *btnRestart;
@property (nonatomic, strong) ZGCountDownTimer *myCountDownTimer;
@property (strong, nonatomic) NSNumber *seconds;
@property (strong, nonatomic) NSNumber *hours;
@property (strong, nonatomic) NSString *myTimer;
@property (strong, nonatomic) NSDate *counterFinishes;

@property (strong, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *doseTitleLable;
@property (strong, nonatomic) IBOutlet UILabel *fireDateTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *counterTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *additionalInforTitleLabel;

@property (strong, nonatomic) IBOutlet UIView *cellBackground;



-(void)updateFonts;

@end
