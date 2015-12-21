//
// CrashlyticsLogger.swift
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
