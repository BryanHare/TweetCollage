//
//  viewOne.h
//  TestApplication
//
//  Created by Bryan on 8/10/16.
//  Copyright © 2016 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface viewOne:UIViewController
{
    IBOutlet UIButton * button;
}

@property (nonatomic, strong) IBOutlet UIButton* button;

-(IBAction)login:(id)sender;

@end