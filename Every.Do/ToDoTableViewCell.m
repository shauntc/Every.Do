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

@end

@implementation ToDoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.toDoTitleLabel.text = self.toDo.title;
    self.toDoPriorityLabel.text = [NSString stringWithFormat:@"%d", self.toDo.priorityNumber];
    self.toDoDescriptionLabel.text = self.toDo.toDoDescription;
    if (self.toDo.priorityNumber <= 1) {
        self.toDoTitleLabel.textColor = [UIColor redColor];
        self.toDoPriorityLabel.textColor = [UIColor redColor];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithToDo:(ToDo*)toDo
{
    self = [super init];
    if (self) {
        _toDo = toDo;
    }
    return self;
}

@end
