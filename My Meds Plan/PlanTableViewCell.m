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
        UIColor *backgroundColor = [UIColor colorWithRGB:0xE5F7FF];
        UIColor *nameTextColor = [UIColor blackColor];
        UIColor *countDownTextColor = [UIColor colorWithRGB:0xaaaaaa];
        UIColor *dateTextColor = [UIColor colorWithRGB:0xf65c29];
        
        NSLog(@"style cell");
        
        self.contentView.backgroundColor = backgroundColor;
        
        // Create new instance of labels
        self.nameTitleLabel = [UILabel newAutoLayoutView];
        [self.nameTitleLabel setTextColor:nameTextColor];
        self.nameTitleLabel.text = @"Medicine Name";
        
        self.doseTitleLable = [UILabel newAutoLayoutView];
        [self.doseTitleLable setTextColor:nameTextColor];
        self.doseTitleLable.text = @"Dose";
        
        self.fireDateTitleLabel = [UILabel newAutoLayoutView];
        [self.fireDateTitleLabel setTextColor:nameTextColor];
        self.fireDateTitleLabel.text = @"Next intake";
        
        self.counterTitleLabel = [UILabel newAutoLayoutView];
        [self.counterTitleLabel setTextColor:nameTextColor];
        self.counterTitleLabel.text = @"Time remaining";
        
        self.nameLabel = [UILabel newAutoLayoutView];
        [self.nameLabel setTextColor:nameTextColor];
        
        self.doseLabel = [UILabel newAutoLayoutView];
        [self.doseLabel setTextColor:nameTextColor];
        
        self.counter = [UILabel newAutoLayoutView];
        [self.counter setTextColor:countDownTextColor];
        
        self.fireDateLabel = [UILabel newAutoLayoutView];
        [self.fireDateLabel setTextColor:dateTextColor];
        
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
        [self.contentView addSubview:self.nameTitleLabel];
        [self.contentView addSubview:self.doseTitleLable];
        [self.contentView addSubview:self.fireDateTitleLabel];
        [self.contentView addSubview:self.counterTitleLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.doseLabel];
        [self.contentView addSubview:btn];
        [self.contentView addSubview:btnRestart];
        [self.contentView addSubview:self.counter];
        [self.contentView addSubview:self.fireDateLabel];
    }
    return self;
}

-(void)updateConstraints
{
    [super updateConstraints];
    if (self.didSetupConstraints) return; // If constraints have been set, don't do anything.
    
    // Setup constraints for the label containing contact name
    [self.nameTitleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.nameTitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:15];
    [self.nameTitleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.contentView withOffset:15];
    
    [self.doseTitleLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.nameTitleLabel withOffset:210];
    [self.doseTitleLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameTitleLabel];
    
    [self.fireDateTitleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.doseTitleLable withOffset:180];
    [self.fireDateTitleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.doseTitleLable];
    
    [self.counterTitleLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.fireDateTitleLabel withOffset:80];
    [self.counterTitleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.fireDateTitleLabel];
    
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameTitleLabel withOffset:6];
    [self.nameLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.nameTitleLabel];
    
    [self.doseLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.doseLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
    [self.doseLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.doseTitleLable];
    
    [btn setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
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
    
    [self.fireDateLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.fireDateLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.counter];
    [self.fireDateLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.fireDateTitleLabel];
    [self.fireDateLabel autoSetDimension:ALDimensionHeight toSize:30];
    
    self.didSetupConstraints = YES;
    NSLog(@"constraints installed");
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // The below call to layoutSubviews on the table view cell's contentView should NOT be necessary.
    // However, in some (but not all!) cases it appears as though the super implementation does not call
    // layoutSubviews on the contentView, which causes all the UILabels to have a frame of CGRectZero.
    
    NSLog(@"layout subviews seconds: %@", self.seconds);
    myCountDownTimer = [ZGCountDownTimer countDownTimerWithIdentifier:self.myTimer];
    myCountDownTimer.delegate = self;
    [myCountDownTimer setupCountDownForTheFirstTime:^(ZGCountDownTimer *timer) {
        timer.totalCountDownTime = [self.seconds doubleValue];
        if (!timer.isRunning) {
            NSLog(@"timer is not running (setup)");
            self.timerIsRunning = NO;
            btn.alpha = 1;
            btnRestart.alpha = 0;
        }else{
            NSLog(@"timer is running (setup)");
            self.timerIsRunning = YES;
            btn.alpha = 0;
            btnRestart.alpha = 1;
        }
    } restoreFromBackUp:^(ZGCountDownTimer *timer) {
        if (!timer.isRunning) {
            NSLog(@"timer is not running (restore)");
            self.timerIsRunning = NO;
            btn.alpha = 1;
            btnRestart.alpha = 0;
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"It's not running anymore"
                                                                message:[NSString stringWithFormat:@"Completed!"]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Dismiss"
                                                      otherButtonTitles:nil];
            [alertView show];
        }else{
            NSLog(@"timer is running! (restore)");
            self.timerIsRunning = YES;
            btn.alpha = 0;
            btnRestart.alpha = 1;
        }
    }];
    
    self.plan = [Plan MR_findFirstByAttribute:@"medicationName" withValue:self.nameLabel.text];
    NSLog(@"%@", self.plan);
    NSDate *fireDate = self.plan.fireDate;
    if (fireDate != nil) {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        
//        [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
//        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
//        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
//        [dateFormatter setDateFormat:@"HH:mm a"];
//        NSString *formattedDateString = [dateFormatter stringFromDate:fireDate];
//        NSLog(@"date formatted : %@", formattedDateString);
//        self.fireDateLabel.text = formattedDateString;
        [self setDate:fireDate];
    }
    [self.contentView layoutSubviews];
}

-(void)setDate:(NSDate *)fDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"HH:mm a"];
    NSString *formattedDateString = [dateFormatter stringFromDate:fDate];
    NSLog(@"date formatted : %@", formattedDateString);
    self.fireDateLabel.text = formattedDateString;
}

-(void)updateFonts{
    UIFont *avenirMedium30 = [UIFont fontWithName:@"Avenir-Medium" size:30];
    UIFont *avenirMedium24 = [UIFont fontWithName:@"Avenir-Medium" size:23];
    UIFont *avenirMedium19 = [UIFont fontWithName:@"Avenir-Medium" size:15];
    
    [self.nameLabel setFont:avenirMedium30];
    [self.doseLabel setFont:avenirMedium24];
    [self.counter setFont:avenirMedium30];
    [self.fireDateLabel setFont:avenirMedium30];
    
    [self.nameTitleLabel setFont:avenirMedium19];
    [self.doseTitleLable setFont:avenirMedium19];
    [self.fireDateTitleLabel setFont:avenirMedium19];
    [self.counterTitleLabel setFont:avenirMedium19];
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
    
}

-(void)restartBtnPress{
    NSLog(@"restart button pressed");
    [UIView animateWithDuration:0.5 animations:^{
        btnRestart.alpha = 0;
        [UIView animateWithDuration:0.8 animations:^{
            btn.alpha = 1;
        }];
    }];
}

-(void)secondUpdated:(ZGCountDownTimer *)sender countDownTimePassed:(NSTimeInterval)timePassed ofTotalTime:(NSTimeInterval)totalTime{
    self.counter.text = [ZGCountDownTimer getDateStringForTimeInterval:(totalTime - timePassed)];
}

- (void)saveContext {
    
}

@end
