//
//  ToDoTableViewCell.m
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-20.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import "ToDoTableViewCell.h"


@interface ToDoTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *toDoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDoPriorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDoDescriptionLabel;
//@property (nonatomic) UISwipeGestureRecognizer *swipeGestureRecognizer;

@end

@implementation ToDoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        _swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureOccured:)];
        self.tintColor = [UIColor blueColor];
    }
    return self;
}



-(void)setToDo:(ToDo *)toDo
{
    _toDo = toDo;
    [self setUpLabels];
    
}

//-(void)swipeGestureOccured:(UISwipeGestureRecognizer*)sender
//{
//    if(sender.direction == UISwipeGestureRecognizerDirectionRight)
//    {
//        self.toDo.isComplete = !self.toDo.isComplete;
//        [self setUpLabels];
//    }
//    else if(sender.direction == UISwipeGestureRecognizerDirectionLeft)
//    {
//        
//    }
//    
//    
//}


-(void)setUpLabels
{
    self.toDoTitleLabel.text = _toDo.title;
    
    //Set priority based on priority number
    if(_toDo.priorityNumber == 1)
    {
        self.toDoPriorityLabel.text = @"High";
    }
    else if(_toDo.priorityNumber == 2)
    {
        self.toDoPriorityLabel.text = @"Normal";
    }
    else if(_toDo.priorityNumber == 3)
    {
        self.toDoPriorityLabel.text = @"Low";
    }
    else
    {
        self.toDoPriorityLabel.text = @"UNKNOWN";
    }
    
    
    
    self.toDoDescriptionLabel.text = _toDo.toDoDescription;
    
    //Make labels red if high priority
    if (_toDo.priorityNumber == 1 && !_toDo.isComplete) {
        self.toDoTitleLabel.textColor = [UIColor redColor];
        self.toDoPriorityLabel.textColor = [UIColor redColor];
    }
    else
    {
        self.toDoPriorityLabel.textColor = [UIColor blackColor];
        self.toDoTitleLabel.textColor = [UIColor blackColor];
    }
    
    //Strikethrough if complete
    if(_toDo.isComplete)
    {
        self.toDoTitleLabel.attributedText = [[NSAttributedString alloc] initWithString:_toDo.title attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
        self.toDoPriorityLabel.attributedText = [[NSAttributedString alloc] initWithString:self.toDoPriorityLabel.text attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//- (instancetype)initWithToDo:(ToDo*)toDo
//{
//    self = [super init];
//    if (self) {
//        _toDo = toDo;
//    }
//    return self;
//}

@end
