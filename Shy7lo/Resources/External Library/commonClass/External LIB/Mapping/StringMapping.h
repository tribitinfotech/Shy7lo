
#import <Foundation/Foundation.h>

@interface StringMapping : NSObject {
    
    NSDictionary *dictLocalization;
    NSDictionary *dictStringMappings;
}

+(StringMapping *)sharedMapping;
-(void)setLanguage;
-(NSString *)stringForKey:(NSString *)strKey;
-(NSString *)alertMsgForKey:(NSString *)strKey;

@end
