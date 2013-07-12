//
//  MapViewController.h
//  MyLocations
//
//  Created by David Wen on 2013-07-12.
//  Copyright (c) 2013 David Wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

- (IBAction)showUser;
- (IBAction)showLocations;

@end
