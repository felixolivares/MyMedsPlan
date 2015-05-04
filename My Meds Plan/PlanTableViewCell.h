//
//  PlanTableViewCell.h
//  My Meds Plan
//
//  Created by Felix Olivares on 5/4/15.
//  Copyright (c) 2015 Felix Olivares. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

-(void)updateFonts;

@end
