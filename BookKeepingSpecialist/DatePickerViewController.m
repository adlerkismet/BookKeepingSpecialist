//
//  DatePickerViewController.m
//  BookKeepingSpecialist
//
//  Created by adlerkismet on 2017/4/8.
//  Copyright © 2017年 adlerkismet. All rights reserved.
//

#import "DatePickerViewController.h"
#import "DetailViewController.h"
@interface DatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong,nonatomic) NSDate *selectedDate;

@end

@implementation DatePickerViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        // To indicate to the system that we have a custom presentation controller, use UIModalPresentationCustom as our modalPresentationStyle
        [self setModalPresentationStyle:UIModalPresentationCustom];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setModalPresentationStyle:UIModalPresentationCustom];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datePicker.date = _currentSelectedDate;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelAction:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)confirmAction:(id)sender {
    self.selectedDate = _datePicker.date;
    if (_backDateBlock) {
        self.backDateBlock(_selectedDate);
    }
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
    
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
