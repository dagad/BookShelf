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
#import "BookData.h"
#import "BookShelf-Swift.h"

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

        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:self.dbPath]) {

        } else {
            [self createTable];
        }

        [self.db open];
    }
    return self;
}

- (void)createTable {

    NSString *dropTable = @"DROP TABLE BookTable;";

    NSString *bookTable = @"CREATE TABLE IF NOT EXISTS BookTable (\
    error TEXT,\
    title TEXT,\
    subtitle TEXT,\
    authors TEXT,\
    publisher TEXT,\
    isbn10 TEXT,\
    isbn13 TEXT,\
    pages TEXT,\
    year TEXT,\
    rating TEXT,\
    description TEXT,\
    price TEXT,\
    imageSource TEXT, \
    url TEXT, \
    pdf BLOB, \
    UNIQUE(isbn10, isbn13) ON CONFLICT REPLACE);";

    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:bookTable];
    }];
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)insertBook:(Book *)book {

    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSData *pdfData = [NSKeyedArchiver archivedDataWithRootObject:book.pdf];
        NSString *sql = @"INSERT OR REPLACE INTO BookTable(error, title, subtitle, authors, publisher, isbn10, isbn13, pages, year, rating, description, price, imageSource, url, pdf) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        [db executeUpdate:sql, book.error, book.title, book.subtitle, book.authors, book.publisher,
         book.isbn10, book.isbn13, book.pages, book.year, book. rating, book.desc, book.price, book.imageSource, book.url, pdfData];
    }];
}

- (void)deleteBook:(Book *)book {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM BookTable WHERE isbn10 = %@ AND isbn13 = %@", book.isbn10, book.isbn13];
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:sql];
    }];
}

- (NSArray<Book *> *)getBooks {
    NSMutableArray<Book *> *books = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM BookTable"];
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *result = [db executeQuery:sql];

        while([result next]) {
            BookData *data = [[BookData alloc] initWithResult:result];
            Book *book = [data createBook];
            [books addObject:book];
        }
        [result close];
    }];
    return books;
}

@end
