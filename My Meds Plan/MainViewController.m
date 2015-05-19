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
#import "AddMedicineViewController.h"
#import "MPColorTools.h"
#import "UINavigationBar+Addition.h"

static NSString *PlanCellIdentifier = @"PlanCellIdentifier";

@interface MainViewController ()
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;
@end

@implementation MainViewController
@synthesize plan;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundView.backgroundColor = [UIColor colorWithRGB:0x4CAAA0];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar makeTransparent];
    [self.tableView registerClass:[PlanTableViewCell class] forCellReuseIdentifier:PlanCellIdentifier];
    self.myResults = [[Plan MR_findAll] mutableCopy];
    NSLog(@"count myResutls %d", [self.myResults count]);
    [self.tableView reloadData];
//    NSLog(@"%@", self.myResults);
    self.view.backgroundColor = [UIColor colorWithRGB:0x4CAAA0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    
//    self.tableView.backgroundColor = [UIColor colorWithRGB:0xe7eff6];
    
    
    [self.view setNeedsUpdateConstraints];
    
//    plan = [self.myResults objectAtIndex:0];
//    NSLog(@"Medicine name : %@", plan.medicationName);
}

-(void)viewWillAppear:(BOOL)animated{
    self.offscreenCells = [NSMutableDictionary dictionary];
    self.medNameToSend = nil; 
    self.myResults = [[Plan MR_findAll] mutableCopy];
    NSLog(@"count myResutls %d", [self.myResults count]);
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
//    PlanTableViewCell *planCell = [tableView dequeueReusableCellWithIdentifier:PlanCellIdentifier];
//    
//    //    planCell = [[PlanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlanCellIdentifier];
//    
//    // Initialize object containing contact info
//    Plan *eachPlan = [self.myResults objectAtIndex:indexPath.row];
////    NSLog(@"eachPlan name : %@", eachPlan.medicationName);
//    
//    planCell.nameLabel.text = [NSString stringWithFormat:@"%@", eachPlan.medicationName];
//    planCell.doseLabel.text = [NSString stringWithFormat:@"%@ %@ every %@ hrs.", eachPlan.unitsPerDose, eachPlan.medicineKind, eachPlan.periodicity];
//    
//    int hours = [eachPlan.periodicity intValue];
//    NSNumber *seconds = [NSNumber numberWithInt:hours*3600];
//    //    NSLog(@"seconds = %@", seconds);
//    planCell.seconds = seconds;
//    
//    planCell.myTimer = [NSString stringWithFormat:@"myTimer%d", indexPath.row];
//    
//        NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
//        planCell.counterFinishes = [[[NSDate date] dateByAddingTimeInterval:hours*60*60] dateByAddingTimeInterval:timeZoneSeconds];
//    
//        planCell.counterFinishes = [[NSDate date] dateByAddingTimeInterval:hours*60*60];
//        planCell.counterFinishes = [[NSDate date] dateByAddingTimeInterval:20];
//    
//    planCell.hours = [NSNumber numberWithInt:hours];
//    
//    [planCell updateFonts];
//    [planCell setNeedsUpdateConstraints];
//    [planCell updateConstraintsIfNeeded];
//    
//    planCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(planCell.bounds));
//
//    [planCell setNeedsLayout];
//    [planCell layoutIfNeeded];        
//    
//    CGFloat height = [planCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    
//    // Add an extra point to the height to account for the cell separator, which is added between the bottom
//    // of the cell's contentView and the bottom of the table view cell.
//    height += 1;
//    
//    NSLog(@"row heigth %f", height);
    
    return 170;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlanTableViewCell *planCell = [tableView dequeueReusableCellWithIdentifier:PlanCellIdentifier];
   
//    planCell = [[PlanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PlanCellIdentifier];

    // Initialize object containing contact info
    Plan *eachPlan = [self.myResults objectAtIndex:indexPath.row];
//    NSLog(@"eachPlan name : %@", eachPlan.medicationName);
    NSLog(@"plan: %@", eachPlan); 
    
    planCell.nameLabel.text = [NSString stringWithFormat:@"%@", eachPlan.medicationName];
    planCell.doseLabel.text = [NSString stringWithFormat:@"%@ %@ every %@ hrs.", eachPlan.unitsPerDose, eachPlan.medicineKind, eachPlan.periodicity];
    planCell.additionalInfoLabel.text = [NSString stringWithFormat:@"%@", eachPlan.additionalInfo];
    if ([eachPlan.otherUser length] > 0) {
        planCell.userLabel.text = [NSString stringWithFormat:@"- %@", eachPlan.otherUser];
    }
    
    int hours = [eachPlan.periodicity intValue];
    NSNumber *seconds = [NSNumber numberWithInt:hours*3600];
//    NSLog(@"seconds = %@", seconds); 
    planCell.seconds = seconds;
    
    planCell.myTimer = [NSString stringWithFormat:@"myTimer%d", indexPath.row];
    
//    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
//    planCell.counterFinishes = [[[NSDate date] dateByAddingTimeInterval:hours*60*60] dateByAddingTimeInterval:timeZoneSeconds];
    
//    planCell.counterFinishes = [[NSDate date] dateByAddingTimeInterval:hours*60*60];
//    planCell.counterFinishes = [[NSDate date] dateByAddingTimeInterval:20];
    
    planCell.hours = [NSNumber numberWithInt:hours]; 
    
    [planCell updateFonts];
    [planCell setNeedsUpdateConstraints];
    [planCell updateConstraintsIfNeeded];
    
    return planCell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        Plan *planToRemove = self.myResults[indexPath.row];
        [planToRemove MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [self.myResults removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSLog(@"insert");
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES; 
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *moreAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        // maybe show an action sheet with more options
        [self.tableView setEditing:NO];
        Plan *planToEdit = [self.myResults objectAtIndex:indexPath.row];
        self.medNameToSend = planToEdit.medicationName;
        [self performSegueWithIdentifier:@"editMedicine" sender:self]; 
    }];
    moreAction.backgroundColor = [UIColor lightGrayColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        Plan *planToRemove = self.myResults[indexPath.row];
        [planToRemove MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [self.myResults removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    return @[deleteAction, moreAction];
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleInsert;
//}

- (void)saveContext {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editMedicine"]) {
        AddMedicineViewController *destViewController = segue.destinationViewController;
        destViewController.medicineNameString = self.medNameToSend;
    }
}


- (IBAction)editButton:(id)sender {
    if ([self.tableView isEditing]) {
        // If the tableView is already in edit mode, turn it off. Also change the title of the button to reflect the intended verb (‘Edit’, in this case).
        [self.tableView setEditing:NO];
        [self.editButtonProperty setTitle:@"Edit"];
    }
    else {
        [self.editButtonProperty setTitle:@"Done"];
        
        // Turn on edit mode
        
        [self.tableView setEditing:YES];
    }
}
@end
