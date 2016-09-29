//
//  addToDoViewController.m
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-20.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import "AddToDoViewController.h"
#import "CoreDataStack.h"
#import "MasterViewController.h"

@interface AddToDoViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmentControl;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;
@property (weak, nonatomic) IBOutlet UIView *totalView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toDo.isComplete = NO;
    self.toDo.priorityNumber = 2;
    
    [self configureView];
}

//-(void)setKeyboarObservers
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardIsAppearing:) name:UIKeyboardDidShowNotification object: nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardIsLeaving:) name:UIKeyboardDidHideNotification object: nil];
// 
//}

-(void)configureView
{
    self.titleTextField.placeholder = @"Enter a Task";
    
    self.prioritySegmentControl.selectedSegmentIndex = self.toDo.priorityNumber - 1;
    self.titleTextField.text = self.toDo.title;
    
    self.navigationController.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *cancelButton =[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonPressed:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.detailsTextView.layer.cornerRadius = 10;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




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


-(void)cancelButtonPressed:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate deleteToDo:self.toDo];
}

-(void)addButtonPressed:(UIBarButtonItem *)sender
{
    if(self.toDo.title)
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate SaveToDo:self.toDo];
    }
    else{
        UIAlertController *emptyTitleAlert = [UIAlertController alertControllerWithTitle:@"No Title" message:@"Can't create a ToDo without a title" preferredStyle:UIAlertControllerStyleAlert];
        
        [emptyTitleAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        
        [self presentViewController:emptyTitleAlert animated:YES completion:nil];
    }
}


@end
