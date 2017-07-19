//
//  ConnectToServer.h
//  AppyIslam
//
//  Created by Bhavesh virani on 17/06/14.
//  Copyright (c) 2014 Haresh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
@protocol ConnectToServerDelegate
- (void) onResultWithData:(NSDictionary *)responseData;
- (void) onError:(NSError *)error;
- (void) onErrorForOutANDin;
@end

@interface ConnectToServer : NSObject{
    NSMutableData *receivedData;
}
@property(nonatomic,retain)id<ConnectToServerDelegate>delegate;
@property(nonatomic,retain) NSString *command;
-(void)CallGetWithUrl:(NSString *)url ;
-(void)CallPostWithUrl:(NSString *)url andDataDictionary:(NSMutableDictionary*)dictionary;
-(void)CallGetURL:(NSString *)url parameters:(NSMutableDictionary *)params;
-(void)CallPostWithUrl:(NSString *)url andDataDictionary:(NSMutableDictionary*)dictionary addPhoto:(NSMutableArray*)arrPhoto;
-(void)OrderCallPostWithUrl:(NSString *)url andDataDictionary:(NSMutableDictionary*)dictionary addPhoto:(NSMutableArray*)arrPhoto;
-(void)CallPostWithUrl:(NSString *)url andDataDictionary:(NSMutableDictionary*)dictionary andFile:(NSData*)fileData andExtension:(NSString*)ext;
@end
