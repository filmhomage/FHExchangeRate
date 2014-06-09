//
//  FHExchangeRateViewController.h
//  FHExchangeRate
//
//  Created by earth on 6/9/14.
//  Copyright (c) 2014 filmhomage.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FHExchangeRateViewController : UIViewController
<UIPickerViewDelegate,
UIPickerViewDataSource,
UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldInputSource;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerSource;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerTarget;
@property (weak, nonatomic) IBOutlet UILabel *labelResult;
@property (weak, nonatomic) IBOutlet UIView *buttonStartCalculate;

@end
