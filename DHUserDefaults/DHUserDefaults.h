//
//  DHUserDefaults.h
//  DHUserDefaults
//
//  Created by kdh on 2017. 12. 1..
//  Copyright © 2017년 Kim Do Hyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface DHUserDefaults : NSObject

+ (DHUserDefaults *)sharedInstance;

@property (nonatomic, strong) FMDatabase *dataBase;

#pragma mark - UserDefaults Table
#pragma mark Setter
- (void)setObject:(id)object key:(NSString *)key;

#pragma mark Getter
- (id)getObjectWithKey:(NSString *)key;

@end
