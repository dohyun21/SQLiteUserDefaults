//
//  DHUserDefaults.m
//  DHUserDefaults
//
//  Created by kdh on 2017. 12. 1..
//  Copyright © 2017년 Kim Do Hyun. All rights reserved.
//

#import "DHUserDefaults.h"

#define DATABASE_NAME @"dh_user_defaults.sqlite"
#define DH_USER_DEFAULTS_TABLE @"dh_user_defaults"

@implementation DHUserDefaults

+ (DHUserDefaults *)sharedInstance {
    static DHUserDefaults *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DHUserDefaults alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir stringByAppendingPathComponent:DATABASE_NAME];
        
        self.dataBase = [FMDatabase databaseWithPath:dbPath];
        
        // 설정 테이블 생성
        [self createPreferenceTable];
    }
    return self;
}

#pragma mark Create
- (void)createPreferenceTable {
    [self.dataBase open];
    
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (" \
                     "'key' TEXT NOT NULL PRIMARY KEY UNIQUE," \
                     "'value' BLOB);", DH_USER_DEFAULTS_TABLE];
    
    BOOL isExistTable = [self.dataBase tableExists:DH_USER_DEFAULTS_TABLE];
    NSLog(@"%@", isExistTable?@"":@"DHUserDefaults Table 생성완료");
    
    [self.dataBase executeUpdate:sql];
    
    [self.dataBase close];
}

#pragma mark Setter
- (void)setObject:(id)object key:(NSString *)key {
    [self.dataBase open];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO '%@' "\
                     "(key, value) VALUES ( ? , ? );", DH_USER_DEFAULTS_TABLE];
    
    if ( [self.dataBase executeUpdate:sql, key, object]) {
        NSLog(@"[DHUserDefault: Saved]\n>>> { %@ : %@ }", key, object);
    } else {
        NSLog(@"[DHUserDefault: Failed to save]\n>>> { %@ : %@ }", key, object);
    }
    
    [self.dataBase close];
}

#pragma mark Getter
- (id)getObjectWithKey:(NSString *)key {
    [self.dataBase open];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE key = '%@';", DH_USER_DEFAULTS_TABLE, key];
    
    FMResultSet *result = [self.dataBase executeQuery:sql];
    id returnObj;
    while ([result next]) {
        returnObj = [result objectForColumn:@"value"];
    }
    [self.dataBase close];
    
    return returnObj;
}

@end
