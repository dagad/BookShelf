//
//  BookDataCenter.m
//  BookShelf
//
//  Created by devdagad on 09/04/2019.
//  Copyright © 2019 dagad. All rights reserved.
//

#import "BookDataCenter.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface BookDataCenter()

@property (strong, nonatomic) FMDatabase *db;
@property (strong, nonatomic) NSString *dbPath;
@property (strong, nonatomic) FMDatabaseQueue *dbQueue;

@end

@implementation BookDataCenter

+ (instancetype)shared
{
    static dispatch_once_t token;
    static BookDataCenter *instance = nil;
    dispatch_once(&token, ^{
        instance = [[BookDataCenter alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        self.dbPath = [NSString stringWithFormat:@"%@bookshelf_db.sqlite3",[self applicationDocumentsDirectory]];
        self.db = [FMDatabase databaseWithPath:self.dbPath];
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
        
        [self.db open];
        
    }
    return self;
}

- (void)createTable {
    
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
