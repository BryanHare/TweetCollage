//
//  tweet.h
//  TweetCollage
//
//  Created by Bryan on 8/13/16.
//  Copyright © 2016 Bryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tweet : NSObject
{
    NSString* tweetId;
    NSDictionary* hashtags;
    NSDictionary* media;

    /*tweet* rewteetedStatus;             //retweeted_status
    NSString* source;                   //source
    int retweetCount;                   //retweet_count
    
    //Save user information

    
    NSDictionary * mediaDict;
    
    //TweetMetadata
    
    NSString* quotedStatusId;           //quoted_status_id_str
    bool isQuotedStatus;
    NSDictionary* tweetMetaData;
    NSString* dateCreated;
    NSDiction* userInformation
    NSString* tweetId;
    
    //Geolocation Data
    NSData* Coordinates;                //coordinates
    NSData* geoInformation;*/
    
}

@property (nonatomic) NSString* tweetID;
@property (nonatomic) NSDictionary* hashtags;
@property (nonatomic) NSDictionary* media;

-(id)init;

@end