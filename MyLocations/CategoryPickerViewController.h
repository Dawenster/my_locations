//
//  CategoryPickerViewController.h
//  MyLocations
//
//  Created by David Wen on 2013-07-11.
//  Copyright (c) 2013 David Wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryPickerViewController;

@protocol CategoryPickerViewControllerDelegate <NSObject>
- (void)categoryPicker:(CategoryPickerViewController *)picker didPickCategory:(NSString *)categoryName;
@end

@interface CategoryPickerViewController : UITableViewController

@property (nonatomic, weak) id <CategoryPickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *selectedCategoryName;

@end
