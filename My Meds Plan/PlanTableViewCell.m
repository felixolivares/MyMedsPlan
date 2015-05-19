//
//  PlanTableViewCell.m
//  My Meds Plan
//
//  Created by Felix Olivares on 5/4/15.
//  Copyright (c) 2015 Felix Olivares. All rights reserved.
//

#import "PlanTableViewCell.h"
#import "PureLayout.h"
#import "MPColorTools.h"
#import "NSString+FontAwesome.h"
#import "ZGCountDownTimer.h"
#import "AppDelegate.h"
#import "Plan.h"


@interface PlanTableViewCell() <ZGCountDownTimerDelegate>

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, assign) BOOL timerIsRunning;

@end

@implementation PlanTableViewCell
@synthesize btn, myCountDownTimer, btnRestart;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UIColor *backgroundColor = [UIColor colorWithRGB:0xE5F7FF];
        UIColor *backgroundColor = [UIColor colorWithRGB:0xfafaf6];
//        UIColor *nameTextColor = [UIColor blackColor];
//        UIColor *backgroundColor = [UIColor colorWithRGB:0x63ace5];
        UIColor *titleTextColor = [UIColor blackColor];
        UIColor *nameTextColor = [UIColor colorWithRGB:0x2a4d69];
        
        UIColor *countDownTextColor = [UIColor colorWithRGB:0xaaaaaa];
        UIColor *dateTextColor = [UIColor colorWithRGB:0xf65c29];
        
        UIColor *cellBackgroundBorderColor = [UIColor colorWithRGB:0xccd0c9];
//        UIColor *cellBackgroundColor = [UIColor colorWithRGB:0xf4f8f0];

        
//        self.contentView.backgroundColor = backgroundColor;
        
        self.cellBackground = [UIView newAutoLayoutView];
        self.cellBackground.layer.cornerRadius = 7;
        self.cellBackground.layer.borderColor = cellBackgroundBorderColor.CGColor;
        self.cellBackground.layer.borderWidth = 1.0f;
        
        self.cellBackground.layer.shadowColor = cellBackgroundBorderColor.CGColor;
        self.cellBackground.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        self.cellBackground.layer.shadowOpacity = 0.65f;
        self.cellBackground.layer.shadowRadius = 1.0f;
        self.cellBackground.layer.shouldRasterize = YES;
        self.cellBackground.opaque = YES;
        [self.cellBackground setBackgroundColor:backgroundColor];
        
        
        // Create new instance of labels
        self.nameTitleLabel = [UILabel newAutoLayoutView];
        [self.nameTitleLabel setTextColor:titleTextColor];
        self.nameTitleLabel.text = @"Medicine Name";
        
        self.doseTitleLable = [UILabel newAutoLayoutView];
        [self.doseTitleLable setTextColor:titleTextColor];
        self.doseTitleLable.text = @"Dose";
        
        self.fireDateTitleLabel = [UILabel newAutoLayoutView];
        [self.fireDateTitleLabel setTextColor:titleTextColor];
        self.fireDateTitleLabel.text = @"Next intake";
        
        self.counterTitleLabel = [UILabel newAutoLayoutView];
        [self.counterTitleLabel setTextColor:titleTextColor];
        self.counterTitleLabel.text = @"Time remaining";
        
        self.additionalInforTitleLabel = [UILabel newAutoLayoutView];
        [self.additionalInforTitleLabel setTextColor:titleTextColor];
        self.additionalInforTitleLabel.text = @"Additional Information:";
        
        self.nameLabel = [UILabel newAutoLayoutView];
        [self.nameLabel setTextColor:nameTextColor];
        
        self.doseLabel = [UILabel newAutoLayoutView];
        [self.doseLabel setTextColor:nameTextColor];
        
        self.counter = [UILabel newAutoLayoutView];
        [self.counter setTextColor:countDownTextColor];
        
        self.fireDateLabel = [UILabel newAutoLayoutView];
        [self.fireDateLabel setTextColor:dateTextColor];
        
        self.additionalInfoLabel = [UILabel newAutoLayoutView];
        [self.additionalInfoLabel setTextColor:nameTextColor];
        
        self.userLabel = [UILabel newAutoLayoutView];
        [self.userLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.userLabel setNumberOfLines:0];
        [self.userLabel setTextColor:nameTextColor];
        [self.userLabel setTextAlignment:NSTextAlignmentRight];

        
        btn = [BButton newAutoLayoutView];
        CGRect buttonFrame = CGRectMake(0, 0, 100, 40);
        btn = [[BButton alloc]initWithFrame:buttonFrame type:BButtonTypeSuccess style:BButtonStyleBootstrapV3 icon:FATimes fontSize:20.0];
        [btn setTitle:@"I took it" forState:UIControlStateNormal];
        [btn addAwesomeIcon:FAClockO beforeTitle:NO];
        [btn addTarget:self action:@selector(tookMedicineBtnPress) forControlEvents:UIControlEventTouchUpInside];
        
        btnRestart = [BButton newAutoLayoutView];
        btnRestart = [[BButton alloc]initWithFrame:buttonFrame type:BButtonTypeWarning style:BButtonStyleBootstrapV3 icon:FAWarning fontSize:20.0];
        [btnRestart setTitle:@"Restart?" forState:UIControlStateNormal];
        [btnRestart addAwesomeIcon:FAWarning beforeTitle:NO];
        [btnRestart addTarget:self action:@selector(restartBtnPress) forControlEvents:UIControlEventTouchUpInside];
        
        NSLog(@"%@", self.seconds); 
        
        
        // Add imageView and label to the cell content view
        [self.contentView addSubview:self.cellBackground];
        [self.contentView addSubview:self.nameTitleLabel];
        [self.contentView addSubview:self.doseTitleLable];
        [self.contentView addSubview:self.fireDateTitleLabel];
        [self.contentView addSubview:self.counterTitleLabel];
        [self.contentView addSubview:self.additionalInforTitleLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.doseLabel];
        [self.contentView addSubview:btn];
        [self.contentView addSubview:btnRestart];
        [self.contentView addSubview:self.counter];
        [self.contentView addSubview:self.fireDateLabel];
        [self.contentView addSubview:self.additionalInfoLabel];
        [self.contentView addSubview:self.userLabel];
    }
    return self;
}

-(void)updateConstraints
{
    [super updateConstraints];
    if (self.didSetupConstraints) return; // If constraints have been set, don't do anything.
    
    // Setup constraints for the label containing contact name
    
    [self.cellBackground setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [self.cellBackground autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5.0f];
    [self.cellBackground autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5.0f];
//    [self.cellBackground autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:4.0f];
    [self.cellBackground autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:4.0f];

    
    
    [self.nameTitleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [self.nameTitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:15];
    [self.nameTitleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.contentView withOffset:15];
    
    [self.doseTitleLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.nameTitleLabel withOffset:210];
    [self.doseTitleLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameTitleLabel];
    
    [self.fireDateTitleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.doseTitleLable withOffset:165];
    [self.fireDateTitleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.doseTitleLable];
    
    [self.counterTitleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.fireDateTitleLabel withOffset:80];
    [self.counterTitleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.fireDateTitleLabel];
    
    
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [self.nameLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
    }];
    [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameTitleLabel withOffset:6];
    [self.nameLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.nameTitleLabel];
//    [self.nameLabel autoSetDimension:ALDimensionHeight toSize:60.]; 
    
    [self.doseLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.doseLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
    [self.doseLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.doseTitleLable];
    
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [btn autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
    }];
    [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:25];
    [btn autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.contentView withOffset:-20];
    [btn autoSetDimension:ALDimensionWidth toSize:150];
    [btn autoSetDimension:ALDimensionHeight toSize:50];
    
    [btnRestart setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [btnRestart autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:btn];
    [btnRestart autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:btn];
    [btnRestart autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:btn];
    [btnRestart autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:btn];
    
    [self.counter setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.counter autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
    [self.counter autoAlignAxis:ALAxisVertical toSameAxisOfView:self.counterTitleLabel];
    [self.counter autoSetDimension:ALDimensionHeight toSize:30];
    
    
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [self.fireDateLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
    }];
    [self.fireDateLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.counter];
    [self.fireDateLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.fireDateTitleLabel];
    [self.fireDateLabel autoSetDimension:ALDimensionHeight toSize:30];
    
//    [self.contentView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.counter withOffset:-20];

    [self.additionalInforTitleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.additionalInforTitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:10.0];
    [self.additionalInforTitleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.nameLabel];
    [self.additionalInforTitleLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:self.fireDateLabel];
    [self.additionalInforTitleLabel autoSetDimension:ALDimensionHeight toSize:30.0f];

    [self.additionalInfoLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.additionalInfoLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.additionalInforTitleLabel];
    [self.additionalInfoLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.additionalInforTitleLabel];
//    [self.additionalInfoLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.contentView withOffset:-70];
    [self.additionalInfoLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.counter];
    [self.additionalInfoLabel autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.userLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.userLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.additionalInfoLabel];
    [self.userLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.btn];
    [self.userLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.btn withOffset:-5.];
    
    [self.cellBackground autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.additionalInfoLabel withOffset:10.];
//    [self.contentView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.cellBackground]; 
    
    self.didSetupConstraints = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // The below call to layoutSubviews on the table view cell's contentView should NOT be necessary.
    // However, in some (but not all!) cases it appears as though the super implementation does not call
    // layoutSubviews on the contentView, which causes all the UILabels to have a frame of CGRectZero.
    
//    NSLog(@"layout subviews seconds: %@", self.seconds);
    self.counterFinishes = [[NSDate date] dateByAddingTimeInterval:[self.hours intValue]*60*60];
//    self.counterFinishes = [[NSDate date] dateByAddingTimeInterval:20];
    
    myCountDownTimer = [ZGCountDownTimer countDownTimerWithIdentifier:self.myTimer];
    myCountDownTimer.delegate = self;
    [myCountDownTimer setupCountDownForTheFirstTime:^(ZGCountDownTimer *timer) {
        timer.totalCountDownTime = [self.seconds doubleValue];
//        timer.totalCountDownTime = 20;
        if (!timer.isRunning) {
//            NSLog(@"timer is not running (setup)");
            self.timerIsRunning = NO;
            btn.alpha = 1;
            btnRestart.alpha = 0;
        }else{
//            NSLog(@"timer is running (setup)");
            self.timerIsRunning = YES;
            btn.alpha = 0;
            btnRestart.alpha = 1;
        }
    } restoreFromBackUp:^(ZGCountDownTimer *timer) {
        if (!timer.isRunning) {
//            NSLog(@"timer is not running (restore)");
            self.timerIsRunning = NO;
            btn.alpha = 1;
            btnRestart.alpha = 0;
            self.fireDateLabel.text = @""; 
        }else{
//            NSLog(@"timer is running! (restore)");
            self.timerIsRunning = YES;
            btn.alpha = 0;
            btnRestart.alpha = 1;
            self.plan = [Plan MR_findFirstByAttribute:@"medicationName" withValue:self.nameLabel.text];
//            NSLog(@"%@", self.plan);
            NSDate *fireDate = self.plan.fireDate;
            if (fireDate != nil) {
                [self setDate:fireDate];
            }
        }
    }];
    
    if ([self.additionalInfoLabel.text length] == 0) {
        self.additionalInfoLabel.text = @"No information";
    }
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
//    [self.contentView layoutSubviews];
}

-(void)setDate:(NSDate *)fDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *formattedDateString = [dateFormatter stringFromDate:fDate];
//    NSLog(@"date formatted : %@", formattedDateString);
    self.fireDateLabel.text = formattedDateString;
}

-(void)updateFonts{
    UIFont *avenirMedium30 = [UIFont fontWithName:@"Avenir-Medium" size:30];
    UIFont *avenirMedium24 = [UIFont fontWithName:@"Avenir-Medium" size:23];
    UIFont *avenirMedium15 = [UIFont fontWithName:@"Avenir-Medium" size:15];
    UIFont *avenirMedium19 = [UIFont fontWithName:@"Avenir-Medium" size:22];
    UIFont *avenirOblique17 = [UIFont fontWithName:@"Avenir-Oblique" size:17];
    
    [self.nameLabel setFont:avenirMedium30];
    [self.doseLabel setFont:avenirMedium24];
    [self.counter setFont:avenirMedium30];
    [self.fireDateLabel setFont:avenirMedium30];
    [self.additionalInfoLabel setFont:avenirOblique17];
    
    [self.nameTitleLabel setFont:avenirMedium15];
    [self.doseTitleLable setFont:avenirMedium15];
    [self.fireDateTitleLabel setFont:avenirMedium15];
    [self.counterTitleLabel setFont:avenirMedium15];
    [self.additionalInforTitleLabel setFont:avenirMedium15];
    [self.userLabel setFont:avenirMedium19];
}


- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)tookMedicineBtnPress{
    NSLog(@"btn pressed");
    self.counterFinishes = [[NSDate date] dateByAddingTimeInterval:[self.hours intValue]*60*60];
//    self.counterFinishes = [[NSDate date] dateByAddingTimeInterval:20];
    [UIView animateWithDuration:0.5 animations:^{
        btn.alpha = 0;
        [UIView animateWithDuration:0.8 animations:^{
            btnRestart.alpha = 1;
        }];
    }];

    [self.myCountDownTimer startCountDown];
    NSLog(@"medicine : %@", self.nameLabel.text);
    self.plan = [Plan MR_findFirstByAttribute:@"medicationName" withValue:self.nameLabel.text];
    NSLog(@"plan fetched : %@", self.plan);
    self.plan.fireDate = self.counterFinishes;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self setDate:self.counterFinishes];
    
    NSLog(@"notification local date : %@", self.counterFinishes);
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = self.counterFinishes;
    localNotification.alertBody = [NSString stringWithFormat:@"%@ needs to take the medicine. %@ %@", self.userLabel.text, self.nameLabel.text, self.fireDateLabel.text];
    localNotification.alertAction = @"View medications";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

-(void)restartBtnPress{
    NSLog(@"restart button pressed");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure?"
                                                        message:[NSString stringWithFormat:@"Do you really want to reset the counter?"]
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Yes",@"No", nil];
    alertView.tag = 200;
    [alertView show];
}

-(void)secondUpdated:(ZGCountDownTimer *)sender countDownTimePassed:(NSTimeInterval)timePassed ofTotalTime:(NSTimeInterval)totalTime{
    self.counter.text = [ZGCountDownTimer getDateStringForTimeInterval:(totalTime - timePassed)];
}


-(void)countDownCompleted:(ZGCountDownTimer *)sender{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Take your medicine!"
                                                        message:[NSString stringWithFormat:@"You need to take your medicine at %@: %@",self.fireDateLabel.text, self.nameLabel.text]
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
    alertView.tag = 100;
    [alertView show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            self.fireDateLabel.text = @"";
            [UIView animateWithDuration:0.5 animations:^{
                btnRestart.alpha = 0;
                [UIView animateWithDuration:0.8 animations:^{
                    btn.alpha = 1;
                }];
            }];
        }
    }
    
    if (alertView.tag == 200) {
        if (buttonIndex == 0) {
            [self.myCountDownTimer resetCountDown];
            self.fireDateLabel.text = @"";
            [UIView animateWithDuration:0.5 animations:^{
                btnRestart.alpha = 0;
                [UIView animateWithDuration:0.8 animations:^{
                    btn.alpha = 1;
                }];
            }];
        }
    }
}

- (void)saveContext {
    
}

@end
