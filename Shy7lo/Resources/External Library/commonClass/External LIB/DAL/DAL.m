#import "DAL.h"
#import "NSString+Extensions.h"

@implementation DAL

static BOOL inOperation;

+ (BOOL)isInOperation {
	return inOperation;
}


+ (void)setInOperation:(BOOL)operationFlag {
	inOperation = operationFlag;
}

- (id)initDatabase:(NSString *)dbName {
	if (self = [super init]) {
        
		NSString *dbPath = [dbName pathInDocumentDirectory];
		
		if(sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
			dbAccessError = YES;
	}
	
	return self;
}

- (id)init {
	if (self = [super init]) {
		NSString *dbPath = [@"Prioritii.sqlite" pathInDocumentDirectory];
		NSLog(@"dbpath===%@",dbPath);
		if(sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK)
			dbAccessError = YES;
	}
	
	return self;
}


- (NSMutableDictionary *)executeDataSet:(NSString *)strQuery {
	NSMutableDictionary  *dctResult = [[NSMutableDictionary alloc] initWithCapacity:0];
    
	const char *sql = [strQuery UTF8String];
	sqlite3_stmt *selectStatement;

	//prepare the select statement
	int returnValue = sqlite3_prepare_v2(database, sql, -1, &selectStatement, NULL);
	if(returnValue == SQLITE_OK)
	{
		sqlite3_bind_text(selectStatement, 1, sql, -1, SQLITE_TRANSIENT);
		//loop all the rows returned by the query.
		NSMutableArray *arrColumns = [[NSMutableArray alloc] initWithCapacity:0];
		for (int i=0; i<sqlite3_column_count(selectStatement); i++) 
		{
			const char *st = sqlite3_column_name(selectStatement, i);
			[arrColumns addObject:[NSString stringWithCString:st encoding:NSUTF8StringEncoding]];
		}
		int intRow =1;
		while(sqlite3_step(selectStatement) == SQLITE_ROW)
		{
			NSMutableDictionary *dctRow = [[NSMutableDictionary alloc] initWithCapacity:0];
			for (int i=0; i<sqlite3_column_count(selectStatement); i++) 				
			{
				int intValue = 0;
				double dblValue =0;
				const char *strValue;
				switch (sqlite3_column_type(selectStatement,i)) 
				{
					case SQLITE_INTEGER:
						intValue  = (int)sqlite3_column_int(selectStatement, i);
						[dctRow setObject:[NSString stringWithFormat:@"%d",intValue] forKey:[arrColumns objectAtIndex:i]];						
						break;
					case SQLITE_FLOAT:
						dblValue = (double)sqlite3_column_double(selectStatement, i);
						[dctRow setObject:[NSString stringWithFormat:@"%f",dblValue] forKey:[arrColumns objectAtIndex:i]];						
						break;
					case SQLITE_TEXT:
						 strValue = (const char *)sqlite3_column_text(selectStatement, i);
						[dctRow setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumns objectAtIndex:i]];						
						break;
					case SQLITE_BLOB:
						strValue = (const char *)sqlite3_column_value(selectStatement, i);
						[dctRow setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumns objectAtIndex:i]];						
						break;
					case SQLITE_NULL:
						[dctRow setObject:@"" forKey:[arrColumns objectAtIndex:i]];						
						break;
					default:
						strValue = (const char *)sqlite3_column_value(selectStatement, i);
						[dctRow setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumns objectAtIndex:i]];
						break;
				}
				
			}
			[dctResult setObject:dctRow forKey:[NSString stringWithFormat:@"Table%d",intRow]];
			[dctRow release];
			intRow ++;
		}
		[arrColumns release];
	}
	
	sqlite3_reset(selectStatement);
	
	return [dctResult autorelease];
}
- (NSMutableArray *)SelectNameArr:(NSString *)strSelQuery {
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
    
    const char *sql = [strSelQuery UTF8String];
    sqlite3_stmt *selectStatment;
    
    int returnValue = sqlite3_prepare_v2(database, sql, -1, &selectStatment, NULL);
    if(returnValue == SQLITE_OK) {
		
        while(sqlite3_step(selectStatment) == SQLITE_ROW)
		{
            const char *strValue;
			// NSString *strValue = (const char *)sqlite3_column_value(selectStatment, 1);
			// NSLog(@"Name=%@",strValue);
            strValue = (const char *)sqlite3_column_text(selectStatment, 1);
            //[dctRow setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumns objectAtIndex:i]]; 
            [arr addObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding]];
        }
		
    }
    return arr;
	
}
- (int)executeScalar:(NSString *)strQuery {
    
	int intResult = -1;
	const char *chrQuery = [strQuery UTF8String];
	sqlite3_stmt *sqlStatement;
	
	int returnValue = sqlite3_prepare_v2(database, chrQuery, -1, &sqlStatement, NULL);
	if(returnValue == SQLITE_OK)
	{		
		returnValue = sqlite3_step(sqlStatement);
		if(returnValue == SQLITE_DONE)
		{
			intResult = 0;
		}
	}
	
	sqlite3_reset(sqlStatement);
	return intResult;
}
- (NSMutableArray *)executeArraySet:(NSString *)strQuery
{
	NSMutableArray  *arryResult = [[NSMutableArray alloc] initWithCapacity:0];
    
	const char *sql = [strQuery UTF8String];
	sqlite3_stmt *selectStatement;
	
	//prepare the select statement
	int returnValue = sqlite3_prepare_v2(database, sql, -1, &selectStatement, NULL);
	if(returnValue == SQLITE_OK)
	{
		sqlite3_bind_text(selectStatement, 1, sql, -1, SQLITE_TRANSIENT);
		//loop all the rows returned by the query.
		NSMutableArray *arrColumns = [[NSMutableArray alloc] initWithCapacity:0];
		for (int i=0; i<sqlite3_column_count(selectStatement); i++) 
		{
			const char *st = sqlite3_column_name(selectStatement, i);
			[arrColumns addObject:[NSString stringWithCString:st encoding:NSUTF8StringEncoding]];
		}
		int intRow =1;
		while(sqlite3_step(selectStatement) == SQLITE_ROW)
		{
			NSMutableDictionary *dctRow = [[NSMutableDictionary alloc] initWithCapacity:0];
			for (int i=0; i<sqlite3_column_count(selectStatement); i++) 				
			{
				int intValue = 0;
				double dblValue =0;
				const char *strValue;
				switch (sqlite3_column_type(selectStatement,i)) 
				{
					case SQLITE_INTEGER:
						intValue  = (int)sqlite3_column_int(selectStatement, i);
						[dctRow setObject:[NSNumber numberWithInt:intValue] forKey:[arrColumns objectAtIndex:i]];
						break;
					case SQLITE_FLOAT:
						dblValue = (double)sqlite3_column_double(selectStatement, i);
						[dctRow setObject:[NSNumber numberWithDouble:dblValue] forKey:[arrColumns objectAtIndex:i]];						
						break;
					case SQLITE_TEXT:
						strValue = (const char *)sqlite3_column_text(selectStatement, i);
						[dctRow setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumns objectAtIndex:i]];						
						break;
					case SQLITE_BLOB:
						strValue = (const char *)sqlite3_column_value(selectStatement, i);
						[dctRow setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumns objectAtIndex:i]];						
						break;
					case SQLITE_NULL:
						[dctRow setObject:@"" forKey:[arrColumns objectAtIndex:i]];						
						break;
					default:
						strValue = (const char *)sqlite3_column_value(selectStatement, i);
						[dctRow setObject:[NSString stringWithCString:strValue encoding:NSUTF8StringEncoding] forKey:[arrColumns objectAtIndex:i]];
						break;
				}
				
			}
			[arryResult addObject:dctRow];
			[dctRow release];
			intRow ++;
		}
		
		[arrColumns release];
	}
	
	sqlite3_reset(selectStatement);
	return [arryResult autorelease];
}


- (NSInteger)maxValue:(NSString*)field inTable:(NSString*)table {
	
    NSInteger iMax = 0;
	NSString *strQuery = [NSString stringWithFormat:@"SELECT Max(%@) as max FROM %@", field, table];
	const char *chrQuery = [strQuery UTF8String];
	sqlite3_stmt *sqlStatement;
	
	int returnValue = sqlite3_prepare_v2(database, chrQuery, -1, &sqlStatement, NULL);
	if(returnValue == SQLITE_OK) {
		if(sqlite3_step(sqlStatement) == SQLITE_ROW){
			NSString*strMax = [NSString stringWithCString:(const char *)sqlite3_column_text(sqlStatement, 0) encoding:NSUTF8StringEncoding];
			iMax = [strMax intValue];
			return iMax;
		}
	}
	return iMax;
}


- (void)dealloc {
	sqlite3_close(database);
	
	[super dealloc];
}

@end
