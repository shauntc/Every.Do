//
//  addToDoViewController.m
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-20.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import "addToDoViewController.h"

@interface addToDoViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmentControl;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;
@property (weak, nonatomic) IBOutlet UIView *totalView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation addToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.prioritySegmentControl.selectedSegmentIndex = self.toDo.priorityNumber - 1;
    self.titleTextField.text = self.toDo.title;
//    self.datePicker.date = self.toDo.dueDate;
    
    
    self.detailsTextView.layer.cornerRadius = 10;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardIsAppearing:) name:UIKeyboardDidShowNotification object: nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardIsLeaving:) name:UIKeyboardDidHideNotification object: nil];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//-(void)keyboardIsAppearing:(NSNotification *)notification
//{
//    
//    
//    
//    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    
//    
//    [UIView setAnimationCurve:[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]];
//    
//    [UIView animateWithDuration:[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] animations:^{
//        CGRect newFrame = self.totalView.frame;
//        newFrame =
//    }]
//    
//    
//    
//}
//
//-(void)keyboardIsLeaving:(NSNotification *)notification
//{
//    
//}

- (instancetype)initWithToDo:(ToDo*)toDo
{
    self = [super init];
    if (self) {
        _toDo = toDo;
    }
    return self;
}


#pragma mark - Input

- (IBAction)prioritySegmentControlChanged:(UISegmentedControl *)sender {
    self.toDo.priorityNumber = (int) sender.selectedSegmentIndex + 1;
}



- (IBAction)titleTextFieldChanged:(UITextField *)sender {
    self.toDo.title = sender.text;
}
- (IBAction)datePickerChanged:(UIDatePicker *)sender {
    self.toDo.dueDate = sender.date;
    
}


-(void)textViewDidChange:(UITextView *)textView
{
    self.toDo.toDoDescription = textView.text;
}



@end
