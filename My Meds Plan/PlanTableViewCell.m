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

@interface PlanTableViewCell()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation PlanTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIColor *backgroundColor = [UIColor colorWithRGB:0xE5F7FF];
        UIColor *nameTextColor = [UIColor blackColor];
        
        self.contentView.backgroundColor = backgroundColor;
        
        // Create new instance of a label for the contact name (full name)
        self.nameLabel = [UILabel newAutoLayoutView];
        [self.nameLabel setTextColor:nameTextColor];
        
        // Add imageView and label to the cell content view
        [self.contentView addSubview:self.nameLabel];
        
    }
    return self;
}

-(void)updateConstraints
{
    [super updateConstraints];
    if (self.didSetupConstraints) return; // If constraints have been set, don't do anything.
    
    // Setup constraints for the label containing contact name
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:10];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:70];
    //[self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
    
    [self.contentView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:15];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // The below call to layoutSubviews on the table view cell's contentView should NOT be necessary.
    // However, in some (but not all!) cases it appears as though the super implementation does not call
    // layoutSubviews on the contentView, which causes all the UILabels to have a frame of CGRectZero.
    [self.contentView layoutSubviews];
}

-(void)updateFonts{
    UIFont *avenirRoman17 = [UIFont fontWithName:@"Avenir-Medium" size:20];
    
    [self.nameLabel setFont:avenirRoman17];
}


- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
