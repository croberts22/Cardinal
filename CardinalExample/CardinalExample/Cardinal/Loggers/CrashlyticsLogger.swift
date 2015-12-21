//
//  CrashlyticsLogger.swift
//  Cardinal
//
//  Created by Corey Roberts.
//

import UIKit

class CrashlyticsLogger: NSObject, Loggable {
    
    var minimumToleranceLevel: CardinalSeverity = .Info
    let queue: dispatch_queue_t = dispatch_queue_create("com.cardinal.log-queue.crashlyticsLogger", DISPATCH_QUEUE_SERIAL)
    
    func write(message: LogMessage) {
        dispatch_async(queue, { () -> Void in
            
            /** 
             * An example implementation of what a CrashlyticsLogger would look like.
             * If you already have it installed, just uncomment the line below.
            */
            
            
            // CLSLogv requires a va_list, even though we've already formatted this string.
            // Just pass in an empty list.
            
            // CLSLogv(message.stringValue(), getVaList([""]))
        })
    }
}
