//
//  viewTwo.m
//  TestApplication
//
//  Created by Bryan on 8/10/16.
//  Copyright © 2016 Bryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "viewOne.h"
#import <STTwitter.h>
#import "AppDelegate.h"

@implementation viewOne

-(id)init{
    return [super init];
}

-(void)viewDidAppear:(BOOL)animated
{

    /*[ref.twitter getHomeTimelineSinceID:nil
                              count:100
                       successBlock:^(NSArray *statuses) {
                           NSLog([statuses componentsJoinedByString:@" , "]);
                       } errorBlock:^(NSError *error) {
                           NSLog(@"Error");
                       }];*/
}

-(IBAction)login:(id)sender
{
    [self.view willRemoveSubview:sender];
    AppDelegate* ref= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [ref._twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID){
        [self getTweetsWithHashTag:@"joy"];
    } errorBlock:^(NSError *error)
    {
        NSLog([error localizedFailureReason]);
    }];
}

-(void) getTweetsWithHashTag:(NSString*) tagToSearch
{
    AppDelegate* ref= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [ref._twitter getSearchTweetsWithQuery:[NSString stringWithFormat:@"%23%@",tagToSearch]
                                   geocode:nil
                                      lang:nil
                                    locale:nil
                                resultType:nil
                                     count:@"200"
                                     until:nil
                                   sinceID:nil
                                     maxID:nil
                           includeEntities:nil
                                  callback:nil
                              successBlock:^(NSDictionary *searchMetadata, NSArray *statuses)
     {
         [self parseStringsForMedia:statuses];
     }
     errorBlock:^(NSError *error)
     {
          NSLog([error localizedFailureReason]);
     }];
}

-(void) parseStringsForMedia:(NSArray*) statuses
{
    __block NSMutableArray *myArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary * s in statuses) {
        NSString* newString = [s descriptionInStringsFileFormat];
        NSRegularExpression *r = [[NSRegularExpression alloc] initWithPattern:@"\\\"media_url\\\" = .*;" options:nil error:nil];
        
        [r enumerateMatchesInString:newString
                            options:nil
                              range:NSMakeRange(0, newString.length)
                         usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop)
         {
             int j = [result numberOfRanges];
             for(int i = 0; i < j; i++)
             {
                 [myArray addObject: [newString substringWithRange:[result rangeAtIndex:i]]];
             }
             
         }];
    }
    
    myArray = [[NSSet setWithArray:myArray] allObjects];
    [self pullImgUrlAndStartImgDownload:myArray];
}

-(void)pullImgUrlAndStartImgDownload:(NSArray*)myArray
{
    NSRegularExpression *r = [[NSRegularExpression alloc] initWithPattern:@"http:\/\/.*((.jpg)|(.png)|(.gif))" options:nil error:nil];
    
    __block NSMutableArray *imgArray = [[NSMutableArray alloc] init];
    int nextHeight = 20;
    for(int i = 0; i < [myArray count]; i++){
        NSTextCheckingResult* result = [r firstMatchInString:[myArray objectAtIndex:i] options:nil range:NSMakeRange(0, [[myArray objectAtIndex:i] length]) ];
        NSRange myRange = [result rangeAtIndex:0];
        NSData* imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[[myArray objectAtIndex:i] substringWithRange:myRange]]];
        [imgArray addObject:[UIImage imageWithData: imageData]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[imgArray objectAtIndex:i]];
        //imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        CGRect frame = imageView.frame;
        
        CGFloat imgViewHeightScale = 80.0f / frame.size.height;
        
        frame.size.height = 80;
        frame.size.width = frame.size.width * imgViewHeightScale;
        frame.origin.y = nextHeight;
        frame.origin.x = 50;
        imageView.frame = frame;
        CGFloat x = imageView.contentScaleFactor;
        [[self view] addSubview:imageView];
        
        nextHeight += 80;
    }
    [self arrageSubViews];
}

-(void) arrageSubViews
{
    CGFloat nextY = 0;
    CGFloat nextX = 0;
    for(int i = 0 ; i< [self.view subviews].count; i++)
    {
        UIView* v = [[self.view subviews] objectAtIndex:i];
        
        CGRect frame = v.frame;
        frame.origin.x = nextX;
        frame.origin.y = nextY;
        nextX += frame.size.width;
        if(nextX > [[self view] frame].size.width)
        {
            nextX = 0;
            nextY += 80;
        }
        
        v.frame = frame;
        
    }
}


@end