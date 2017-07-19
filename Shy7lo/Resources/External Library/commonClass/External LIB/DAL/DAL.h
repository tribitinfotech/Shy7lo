#import <Foundation/Foundation.h>
//#import "sqlite3.h"
#import <sqlite3.h>

@interface DAL : NSObject {
	sqlite3 *database;
	BOOL dbAccessError;
}
+ (BOOL)isInOperation;
+ (void)setInOperation:(BOOL)operationFlag;

- (id)initDatabase:(NSString *)dbName;
- (NSMutableDictionary *)executeDataSet:(NSString *)strQuery;
- (int)executeScalar:(NSString *)strQuery;
- (NSMutableArray *)executeArraySet:(NSString *)strQuery;
- (NSMutableArray *)SelectNameArr:(NSString *)strSelQuery ;
- (NSInteger)maxValue:(NSString*)field inTable:(NSString*)table;

@end
