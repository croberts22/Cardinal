//
//  Logger.m
//
//  Created by Corey Roberts.
//

#import "Logger.h"
#import "CardinalExample-Swift.h"

@interface Logger()

@property (nonatomic, copy) NSArray *loggers;
@property (nonatomic, strong) dispatch_queue_t logQueue;

@end

@implementation Logger

#pragma mark - Lifecycle Methods

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        _logQueue = dispatch_queue_create("com.cardinal.log-queue", NULL);
        _loggers = [NSArray new];
    }
    return self;
}

+ (Logger *)sharedLogger
{
    static dispatch_once_t onceToken;
    static Logger *sharedLogger = nil;
    
    dispatch_once(&onceToken, ^{
        sharedLogger = [[Logger alloc] init];
    });
    
    return sharedLogger;
}

- (void)addLogger:(NSObject<Loggable> *)logger
{
    if (logger) {
        NSMutableArray *mutableLoggers = [self.loggers mutableCopy];
        [mutableLoggers addObject:logger];
        self.loggers = [mutableLoggers copy];
    }
}

- (void)addLoggers:(NSArray<Loggable> *)loggers
{
    for (id<Loggable> logger in loggers) {
        [self addLogger:logger];
    }
}

#pragma mark - Logging Methods

+ (void)log:(CardinalSeverity)severity category:(CardinalCategory)category file:(char *)file function:(const char *)function lineNumber:(int)lineNumber format:(NSString *)formatString, ...
{
    va_list args;
    
    if (formatString) {
        va_start(args, formatString);
        [self log:severity category:category file:file function:function lineNumber:lineNumber format:formatString args:args];
        va_end(args);
    }
}

+ (void)log:(CardinalSeverity)severity category:(CardinalCategory)category file:(char *)file function:(const char *)function lineNumber:(int)lineNumber format:(NSString *)formatString args:(va_list)argList
{
    if (formatString) {
        NSString *string = [[NSString alloc] initWithFormat:formatString arguments:argList];
        [self log:severity category:category file:file function:function lineNumber:lineNumber string:string];
    }
}

+ (void)log:(CardinalSeverity)severity category:(CardinalCategory)category file:(char *)file function:(const char *)function lineNumber:(int)lineNumber string:(NSString *)string
{
    if (string) {
        LogMessage *logMessage = [[LogMessage alloc] initWithLog:string severityLevel:severity category:category file:[NSString stringWithFormat:@"%s", file] function:[NSString stringWithFormat:@"%s", function] lineNumber:lineNumber];
        [[Logger sharedLogger] queueMessage:logMessage];
    }
}

- (void)queueMessage:(LogMessage *)logMessage
{
    [self addMessage:logMessage toQueue:self.logQueue];
}

- (void)addMessage:(LogMessage *)message toQueue:(dispatch_queue_t)queue
{
    dispatch_async(queue, ^{
        for (NSObject<Loggable> *logger in self.loggers) {
            // If the message severity is higher than the logger's lower tolerance level,
            // then write to the logger. Otherwise, ignore.
            if (message.severityLevel >= logger.minimumToleranceLevel) {
                [logger write:message];
            }
        }
    });
}

@end
