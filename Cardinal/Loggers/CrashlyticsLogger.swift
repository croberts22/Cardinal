//
//  CrashlyticsLogger.swift
//  iMapMy3
//
//  Created by Roberts, Corey on 7/15/15.
//  Copyright (c) 2015 MapMyFitness. All rights reserved.
//

import UIKit

class CrashlyticsLogger: NSObject, Loggable {
    
    var minimumToleranceLevel = UALoggerSeverityLevel.Info
    let queue = dispatch_queue_create("com.mapmyfitness.log-queue.crashlyticsLogger", DISPATCH_QUEUE_SERIAL) as dispatch_queue_t
    
    func write(message: LogMessage) {
        dispatch_async(queue, { () -> Void in
            // CLSLogv requires a va_list, even though we've already formatted this string.
            // Just pass in an empty list.
            CLSLogv(message.stringValue(), getVaList([""]))
        })
    }
}
