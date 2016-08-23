//
//  viewOne.h
//  TweetCollage
//
//  Created by Bryan on 8/10/16.
//  Copyright © 2016 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MainView:UIViewController
{
    IBOutlet UIButton * searchButton;
    IBOutlet UITextField* searchBarTextField;
}

@property (nonatomic, strong) IBOutlet UIButton* searchButton;
@property (nonatomic,strong) IBOutlet UITextField* searchBarTextField;

-(IBAction)login:(id)sender;

@end