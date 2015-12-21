//
// ConsoleLogger.swift
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

class ConsoleLogger: NSObject, Loggable {

    var minimumToleranceLevel = CardinalSeverity.Debug
    let queue = dispatch_queue_create("com.cardinal.log-queue.consoleLogger", DISPATCH_QUEUE_SERIAL) as dispatch_queue_t
    
    var enableColors = false
    
    override init() {
        super.init()
        configureDefaultColors()
    }
    
    func write(message: LogMessage) {
        dispatch_async(queue, { () -> Void in
           
            /**
            * Using NSLog() instead of print() due to synchronicity issues, as well
            * as being able to read content on the device console versus the debugger.
            *
            * However, feel free to choose whichever method you prefer.
            *
            * :see: http://stackoverflow.com/a/25951564/692051 for more info.
            */
            
            // print(self.colorCodeIfNeeded(message))
            
            NSLog("%@", self.colorCodeIfNeeded(message))
        })
    }
    
    // MARK: - TTY Color Methods
    
    
    private func configureDefaultColors() {
        configureColor(.Debug, foregroundColor: UIColor.grayColor(), backgroundColor: UIColor.clearColor())
        configureColor(.Info, foregroundColor: UIColor.whiteColor(), backgroundColor: UIColor.clearColor())
        configureColor(.Warning, foregroundColor: UIColor.orangeColor(), backgroundColor: UIColor.clearColor())
        configureColor(.Error, foregroundColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor())
    }
    
    private func colorCodeIfNeeded(message: LogMessage) -> String {
        
        let string = message.stringValue(displayTimestamp: false)
        
        if enableColors {
            let colorCodedString = string
            
            return colorCodedString
        }
        
        return string
    }
    
    func configureColor(severity: CardinalSeverity, foregroundColor: UIColor, backgroundColor: UIColor) {

    }
}


private class XcodeColors {
    
}
