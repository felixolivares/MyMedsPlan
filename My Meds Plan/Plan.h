//
//  Plan.h
//  
//
//  Created by Felix Olivares on 5/1/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Plan : NSManagedObject

@property (nonatomic, retain) NSString * medicationName;
@property (nonatomic, retain) NSDate * fireDate;
@property (nonatomic, retain) NSString * additionalInfo;
@property (nonatomic, retain) NSNumber * periodicity;
@property (nonatomic, retain) NSNumber * unitsPerDose;
@property (nonatomic, retain) NSString * medicineKind;

@end
