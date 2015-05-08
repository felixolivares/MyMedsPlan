//
//  MainViewController.m
//  My Meds Plan
//
//  Created by Felix Olivares on 4/30/15.
//  Copyright (c) 2015 Felix Olivares. All rights reserved.
//

#import "MainViewController.h"
#import "PlanTableViewCell.h"
#import "Plan.h"

static NSString *PlanCellIdentifier = @"PlanCellIdentifier";

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize plan;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[PlanTableViewCell class] forCellReuseIdentifier:PlanCellIdentifier];
    
    self.myResults = [Plan MR_findAll];
    
    NSLog(@"%@", self.myResults);
    
    [self.view setNeedsUpdateConstraints];
    
//    plan = [self.myResults objectAtIndex:0];
//    NSLog(@"Medicine name : %@", plan.medicationName);
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData]; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count myResults %lu", (unsigned long)[self.myResults count]); 
    return [self.myResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    PlanTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:PlanCellIdentifier];
    
    PlanTableViewCell *planCell = [tableView dequeueReusableCellWithIdentifier:PlanCellIdentifier];
   
//    planCell = [[PlanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlanCellIdentifier];

    // Initialize object containing contact info
    Plan *eachPlan = [self.myResults objectAtIndex:indexPath.row];
    NSLog(@"eachPlan name : %@", eachPlan.medicationName); 
    
    planCell.nameLabel.text = [NSString stringWithFormat:@"%@", eachPlan.medicationName];
    planCell.doseLabel.text = [NSString stringWithFormat:@"%@ %@ every %@ hrs.", eachPlan.unitsPerDose, eachPlan.medicineKind, eachPlan.periodicity];
    
    int hours = [eachPlan.periodicity intValue];
    NSNumber *seconds = [NSNumber numberWithInt:hours*3600];
    NSLog(@"seconds = %@", seconds); 
    planCell.seconds = seconds;
    
    planCell.myTimer = [NSString stringWithFormat:@"myTimer%d", indexPath.row];
    
//    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
//    planCell.counterFinishes = [[[NSDate date] dateByAddingTimeInterval:hours*60*60] dateByAddingTimeInterval:timeZoneSeconds];
    
    planCell.counterFinishes = [[NSDate date] dateByAddingTimeInterval:hours*60*60];
    
    [planCell updateFonts];
    [planCell setNeedsUpdateConstraints];
    [planCell updateConstraintsIfNeeded];
    
    return planCell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
