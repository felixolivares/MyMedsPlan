//
//  MainViewController.h
//  My Meds Plan
//
//  Created by Felix Olivares on 4/30/15.
//  Copyright (c) 2015 Felix Olivares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plan.h"

@interface MainViewController : UIViewController <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) NSArray *myResults;
@property (weak, nonatomic) Plan *plan;
@end
