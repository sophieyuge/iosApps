//
//  PickerViewHelper.h
//  CoreDataTest
//
//  Created by Yuge Xiong on 2018-11-06.
//  Copyright © 2018 sophieyuge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewHelper : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

- (void)setArray:(NSArray *)inputArray;
- (void)addElement:(NSObject *)inputElement;
- (NSObject *)getElementOfIndex:(NSInteger)index;

@end
