//
// Cardinal.h
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

@import UIKit;

@protocol Loggable;

typedef NS_ENUM(NSUInteger, CardinalSeverity) {
    CardinalSeverityDebug,
    CardinalSeverityInfo,
    CardinalSeverityWarning,
    CardinalSeverityError
};

typedef NS_ENUM(NSUInteger, CardinalCategory) {
    CardinalCategoryUnspecified,
    CardinalCategoryNetwork,
    CardinalCategoryDatabase,
    CardinalCategoryUserInterface,
    CardinalCategoryAnalytics
};


@interface Cardinal : NSObject

/**
 *
 * Macros
 * ------------------------------------------------------------------
 *
 * The usage of these macros are strongly preferred.
 * Each macro comes in two flavors: one that includes a general
 * category, and one that does not.
 *
 * Use Log[Severity]Category() to specify a category that you
 * would like to log against. For example:
 *
 *  LogInfoCategory( CardinalCategoryNetwork, @"The network is down." );
 *
 *  This turns into: @"[NETWORK] -[method](line) The network is down."
 *
 * Be smart when choosing severity levels. Loggers have their own preferred
 * tolerance level. Choosing the wrong kind of severity can lead to a logger
 * not saving your statement. Some examples on use cases:
 *
 * - Debug: Something you want logged for debugging/testing purposes.
 *
 * - Info: Events of some importance that happen (i.e. button was tapped,
 *   view was displayed, network reachability status, etc.)
 *
 * - Warning: Events that do not follow the happy path, or events that
 *   are allowed, but aren't necessarily satisfiable (i.e. workout failed
 *   to sync, web request timed out, memory pressure was issued, etc.)
 *
 * - Error: Events that aren't acceptable and should not happen (i.e.
 *   server returned a 400-500, an exception was thrown and was caught,
 *   core data store failed to mount, etc.)
 *
 **/

/**
 *  A macro that conveniently sets the file, function, and line number of a log statement.
 *
 *  @param s   The severity of the message.
 *  @param c   The category of the message.
 *  @param f   A format string
 *  @param ... A list of C-style arguments.
 */
#define Log( s, c, f, ... ) \
[Cardinal log:s category:c file:__FILE__ function:__PRETTY_FUNCTION__ lineNumber:__LINE__ format:f, ## __VA_ARGS__]

// Debug
#define LogDebugCategory( category, format, ...) \
Log( CardinalSeverityDebug, category, format, ##__VA_ARGS__ )

#define LogDebug( format, ... ) \
LogDebugCategory( CardinalCategoryUnspecified, format, ##__VA_ARGS__ )

// Info
#define LogInfoCategory( category, format, ...) \
Log( CardinalSeverityInfo, category, format, ##__VA_ARGS__ )

#define LogInfo( format, ... ) \
LogInfoCategory( CardinalCategoryUnspecified, format, ##__VA_ARGS__ )

// Warning
#define LogWarningCategory( category, format, ...) \
Log( CardinalSeverityWarning, category, format, ##__VA_ARGS__ )

#define LogWarning( format, ... ) \
LogWarningCategory( CardinalCategoryUnspecified, format, ##__VA_ARGS__ )

// Error
#define LogErrorCategory( category, format, ...) \
Log( CardinalSeverityError, category, format, ##__VA_ARGS__ )

#define LogError( format, ... ) \
LogErrorCategory( CardinalCategoryUnspecified, format, ##__VA_ARGS__ )


/**
 *  The shared logger.
 *
 *  @return A shared logger.
 */
+ (Cardinal *)sharedLogger;

/**
 *  Adds a logger that conforms to Loggable.
 *
 *  @param logger A logger that conforms to Loggable.
 */
- (void)addLogger:(id<Loggable>)logger;

/**
 *  Adds an array of loggers that conform to Loggable.
 *
 *  @param loggers An array of objects that conform to Loggable.
 */
- (void)addLoggers:(NSArray<Loggable> *)loggers;

/**
 *  Logs a statement into the shared logger's registered loggers.
 *
 *  @discussion Use this method if you do not want to use the macros defined below.
 *
 *  @param severity     The severity level of the message.
 *  @param category     The category of the message.
 *  @param file         The file in which this message came from.
 *  @param function     The function in which this message came from.
 *  @param lineNumber   The line number at which this message was invoked.
 *  @param formatString A formatted string, following a variadic parameter of arguments.
 */
+ (void)log:(CardinalSeverity)severity category:(CardinalCategory)category file:(char *)file function:(const char *)function lineNumber:(int)lineNumber format:(NSString *)formatString, ...;

/**
 *  Logs a statement (with an already-created argument list) into the shared logger's registered loggers.
 *
 *  @discussion Use this method if you do not want to use the macros defined below.
 *
 *  @param severity     The severity level of the message.
 *  @param category     The category of the message.
 *  @param file         The file in which this message came from.
 *  @param function     The function in which this message came from.
 *  @param lineNumber   The line number at which this message was invoked.
 *  @param formatString A format string.
 *  @param argList      A list of C-style arguments.
 */
+ (void)log:(CardinalSeverity)severity category:(CardinalCategory)category file:(char *)file function:(const char *)function lineNumber:(int)lineNumber format:(NSString *)formatString args:(va_list)argList;

/**
 *  Logs a statement into the shared logger's registered loggers.
 *
 *  @discussion Use this method if you do not want to use the macros defined below.
 *
 *  @param severity     The severity level of the message.
 *  @param category     The category of the message.
 *  @param file         The file in which this message came from.
 *  @param function     The function in which this message came from.
 *  @param lineNumber   The line number at which this message was invoked.
 *  @param string       A string.
 */
+ (void)log:(CardinalSeverity)severity category:(CardinalCategory)category file:(char *)file function:(const char *)function lineNumber:(int)lineNumber string:(NSString *)string;


@end
