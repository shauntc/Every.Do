//
//  DetailViewController.h
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-20.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

