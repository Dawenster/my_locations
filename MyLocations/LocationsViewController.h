//
//  LocationsViewController.h
//  MyLocations
//
//  Created by David Wen on 2013-07-11.
//  Copyright (c) 2013 David Wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationsViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
