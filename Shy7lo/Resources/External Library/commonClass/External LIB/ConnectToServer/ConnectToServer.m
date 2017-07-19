//
//  ConnectToServer.m
//  AppyIslam
//
//  Created by Bhavesh virani on 17/06/14.
//  Copyright (c) 2014 Haresh. All rights reserved.
//

#import "ConnectToServer.h"
#import "constant.h"
#import <UIKit/UIKit.h>

@implementation ConnectToServer
@synthesize command;
-(void)CallGetWithUrl:(NSString *)url {

        
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url1 = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:url1 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
       NSURLConnection *registerURLConnection = [NSURLConnection connectionWithRequest:request delegate:self];
        
    if (registerURLConnection)
    {
        receivedData=[[NSMutableData alloc]init];
    }


}


-(void)CallGetURL:(NSString *)url parameters:(NSMutableDictionary *)params{
	NSString *parStr =[self getString:params];
    NSString *requestUrl=[NSString stringWithFormat:@"%@%@", url,parStr];
	 
	NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestUrl]];
	[theRequest setHTTPMethod:@"GET"];
	NSURLConnection *theconnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
 	if (theconnection) {
		receivedData = [NSMutableData data] ;
	}
    
}

-(NSString *)getString:(NSMutableDictionary *)Params{
    if (Params!=nil){
        NSString *postStr=@"";
        for(int i=0;i<[Params count];i++){
            NSString *key = [[[Params allKeys] objectAtIndex:i] description];
            postStr = [postStr stringByAppendingString:key];
            postStr = [postStr stringByAppendingString:@"="];
            postStr = [postStr stringByAppendingString:[Params objectForKey:key]];
            if(i < [Params count] - 1)
                postStr = [postStr stringByAppendingString:@"&"];
        }
        NSString *str=[NSString stringWithFormat:@"?%@",postStr];
        return [self urlEncode:str];
    }else{
        return @"";
    }
}
- (NSString *) urlEncode:(NSString *)str {
    NSString *string = str;
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

-(void)CallPostWithUrl:(NSString *)url andDataDictionary:(NSMutableDictionary*)dictionary{

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:300];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    for (id key in dictionary)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",[dictionary valueForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setURL:[NSURL URLWithString:url]];
    
    
    NSURLConnection *registerURLConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    if (registerURLConnection)
    {
        receivedData=[[NSMutableData alloc]init];
    }
    
}


///icloud files

-(void)CallPostWithUrl:(NSString *)url andDataDictionary:(NSMutableDictionary*)dictionary andFile:(NSData*)fileData andExtension:(NSString*)ext{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:300];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    if (fileData != nil)
    {
        NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
        NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
        NSString *photoID = [NSString stringWithFormat:@"%@",timeStampObj];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"%@\"; filename=\"%@.%@\"\r\n",@"chat_cloud_file",[[ext componentsSeparatedByString:@"."] objectAtIndex:0] ,[[ext componentsSeparatedByString:@"."] objectAtIndex:1]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[NSData dataWithData:fileData]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    for (id key in dictionary)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",[dictionary valueForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setURL:[NSURL URLWithString:url]];
    
    
    NSURLConnection *registerURLConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    if (registerURLConnection)
    {
        receivedData=[[NSMutableData alloc]init];
    }
    
}



-(void)CallPostWithUrl:(NSString *)url andDataDictionary:(NSMutableDictionary*)dictionary addPhoto:(NSMutableArray*)arrPhoto{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:300];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    for (int i=0; i<arrPhoto.count; i++) {
        
         NSString *strKey=[NSString stringWithFormat:@"chat_image_%d",i+1];
        
        if ([arrPhoto objectAtIndex:i] != nil)
        {
            NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
            NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
            NSString *photoID = [NSString stringWithFormat:@"%@",timeStampObj];
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"%@\"; filename=\"%@.png\"\r\n",strKey,photoID] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[NSData dataWithData:UIImageJPEGRepresentation([arrPhoto objectAtIndex:i] ,1)]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }

    }
    
    for (id key in dictionary)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",[dictionary valueForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setURL:[NSURL URLWithString:url]];
    
    
    NSURLConnection *registerURLConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    if (registerURLConnection)
    {
        receivedData=[[NSMutableData alloc]init];
    }
    
}




///order

-(void)OrderCallPostWithUrl:(NSString *)url andDataDictionary:(NSMutableDictionary*)dictionary addPhoto:(NSMutableArray*)arrPhoto{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:300];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    
    
    
    
    for (int i=0; i<arrPhoto.count; i++) {
        
        NSString *strKey=[NSString stringWithFormat:@"order_chat_image_%d",i+1];
        
        if ([arrPhoto objectAtIndex:i] != nil)
        {
            NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
            NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
            NSString *photoID = [NSString stringWithFormat:@"%@",timeStampObj];
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"%@\"; filename=\"%@.png\"\r\n",strKey,photoID] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[NSData dataWithData:UIImageJPEGRepresentation([arrPhoto objectAtIndex:i] ,1)]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
    }
    
    
    
    for (id key in dictionary)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",[dictionary valueForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setURL:[NSURL URLWithString:url]];
    
    
    NSURLConnection *registerURLConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    if (registerURLConnection)
    {
        receivedData=[[NSMutableData alloc]init];
    }
    
}

#pragma mark - connection delegates

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
   
        [receivedData setLength:0];
   
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
        [receivedData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
  //  NSLog(@"ERror--->%@",error);

	
	 
    [self.delegate onError:error];

	 
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
        NSError *error;
        NSMutableDictionary *responsedict=[NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:&error];

	 
     //  NSLog(@"Response:%@",responsedict);
    if ([command isEqual:nil]) {
        command=@"";
    }

    [responsedict setObject:command forKey:COMMAND];
   // NSLog(@"Response:%@",responsedict);
     [self.delegate onResultWithData:responsedict];
        
    
    
}


@end
