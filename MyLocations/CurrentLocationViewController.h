//
//  FirstViewController.h
//  MyLocations
//
//  Created by David Wen on 2013-07-10.
//  Copyright (c) 2013 David Wen. All rights reserved.
//

@interface CurrentLocationViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, strong) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UIButton *tagButton;
@property (nonatomic, strong) IBOutlet UIButton *getButton;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet UILabel *latitudeTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *longitudeTextLabel;
@property (nonatomic, strong) IBOutlet UIView *panelView;

- (IBAction)getLocation:(id)sender;

@end
