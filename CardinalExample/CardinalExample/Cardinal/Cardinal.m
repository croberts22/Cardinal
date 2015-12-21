//
// Cardinal.m
//
// Copyright (c) 2015 Corey Roberts
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "Cardinal.h"
#import "CardinalExample-Swift.h"

@interface Cardinal()

@property (nonatomic, copy) NSArray *loggers;
@property (nonatomic, strong) dispatch_queue_t logQueue;

@end

@implementation Cardinal

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

+ (Cardinal *)sharedLogger
{
    static dispatch_once_t onceToken;
    static Cardinal *sharedLogger = nil;
    
    dispatch_once(&onceToken, ^{
        sharedLogger = [[Cardinal alloc] init];
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
        [[Cardinal sharedLogger] queueMessage:logMessage];
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
