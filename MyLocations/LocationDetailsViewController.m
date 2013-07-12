//
//  LocationDetailsViewController.m
//  MyLocations
//
//  Created by David Wen on 2013-07-11.
//  Copyright (c) 2013 David Wen. All rights reserved.
//

#import "LocationDetailsViewController.h"
#import "HudView.h"
#import "Location.h"

@interface LocationDetailsViewController ()

@end

@implementation LocationDetailsViewController {
    NSString *descriptionText;
    NSString *categoryName;
    NSDate *date;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        descriptionText = @"";
        categoryName = @"No Category";
        date = [NSDate date];
    }
    return self;
}

- (NSString *)stringFromPlacemark:(CLPlacemark *)thePlacemark
{
    return [NSString stringWithFormat:@"%@ %@, %@, %@ %@, %@",
            self.placemark.subThoroughfare, self.placemark.thoroughfare,
            self.placemark.locality, self.placemark.administrativeArea,
            self.placemark.postalCode, self.placemark.country];
}

- (NSString *)formatDate:(NSDate *)theDate
{
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
    }
    
    return [formatter stringFromDate:theDate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.descriptionTextView.text = descriptionText;
    self.categoryLabel.text = categoryName;
    
    self.descriptionTextView.text = @"";
    self.categoryLabel.text = @"";
    
    self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f", self.coordinate.latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"%.8f", self.coordinate.longitude];
    
    if (self.placemark != nil) {
        self.addressLabel.text = [self stringFromPlacemark:self.placemark];
    } else {
        self.addressLabel.text = @"No Address Found";
    }
    
    self.dateLabel.text = [self formatDate:date];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(hideKeyboard:)];
    
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideKeyboard:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    
    if (indexPath != nil && indexPath.section == 0 && indexPath.row == 0) {
        return;
    }
    
    [self.descriptionTextView resignFirstResponder];
}

- (void)closeScreen
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender
{
    HudView *hudView = [HudView hudInView:self.navigationController.view animated:YES];
    hudView.text = @"Tagged";
    
    Location *location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
    
    location.locationDescription = descriptionText;
    location.category = categoryName;
    location.latitude = [NSNumber numberWithDouble:self.coordinate.latitude];
    location.longitude = [NSNumber numberWithDouble:self.coordinate.longitude];
    location.date = date;
    location.placemark = self.placemark;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        FATAL_CORE_DATA_ERROR(error);
        return;
    }
    
    [self performSelector:@selector(closeScreen) withObject:nil afterDelay:0.6];
}

- (IBAction)cancel:(id)sender
{
    [self closeScreen];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 88;
    } else if (indexPath.section == 2 && indexPath.row == 2) {
        
        CGRect rect = CGRectMake(100, 10, 190, 1000);
        self.addressLabel.frame = rect;
        [self.addressLabel sizeToFit];
        
        rect.size.height = self.addressLabel.frame.size.height;
        self.addressLabel.frame = rect;
        
        return self.addressLabel.frame.size.height + 20;
    } else {
        return 44;
    }
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)theTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    descriptionText = [theTextView.text stringByReplacingCharactersInRange:range withString:text];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)theTextView
{
    descriptionText = theTextView.text;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickCategory"]) {
        CategoryPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        controller.selectedCategoryName = categoryName;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return indexPath;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.descriptionTextView becomeFirstResponder];
    }
}

#pragma mark - CategoryPickerViewControllerDelegate

- (void)categoryPicker:(CategoryPickerViewController *)picker didPickCategory:(NSString *)theCategoryName
{
    categoryName = theCategoryName;
    self.categoryLabel.text = categoryName;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
