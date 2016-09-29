//
//  DetailViewController.m
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-20.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmentedControl;
@property (weak, nonatomic) IBOutlet UISwitch *isCompleteSwitch;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setToDo:(ToDo*)newToDo {
    if (_toDo != newToDo) {
        _toDo = newToDo;

        // Update the view.
        [self configureView];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self configureView];
}



- (void)configureView {
    // Update the user interface for the detail item.
    if (self.toDo) {
        self.prioritySegmentedControl.selectedSegmentIndex = self.toDo.priorityNumber - 1;
        self.detailsTextView.text = self.toDo.toDoDescription;
        self.title = self.toDo.title;
        [self.isCompleteSwitch setOn:self.toDo.isComplete];
    }
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark: Input

- (IBAction)isCompleteChanged:(UISwitch *)sender {
    self.toDo.isComplete = sender.isOn;
}

- (IBAction)prioritySegmentedControlChanged:(UISegmentedControl *)sender {
    self.toDo.priorityNumber = (int)sender.selectedSegmentIndex + 1;
}

-(void)textViewDidChange:(UITextView *)textView
{
    self.toDo.toDoDescription = textView.text;
}



@end
