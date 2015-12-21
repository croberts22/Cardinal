//
//  FileLogger.swift
//  iMapMy3
//
//  Created by Roberts, Corey on 7/14/15.
//  Copyright (c) 2015 MapMyFitness. All rights reserved.
//

import UIKit

// TODO: When Swift 2 rolls out, update internal methods as private appropriately
// and add @testable import iMapMy3 to unit tests.
class FileLogger: NSObject, Loggable {

    private static let defaultMaxLogSize = 2000000 // 2MB
    private let logFilename = "data.log"
    
    // Only log 2MB worth of data for release.
    // 10MB for everything else.
    #if DISTRIBUTION
    var maxLogSize = defaultMaxLogSize
    #else
    var maxLogSize = 10000000 // 10MB
    #endif
    
    var minimumToleranceLevel = UALoggerSeverityLevel.Info
    let queue = dispatch_queue_create("com.mapmyfitness.log-queue.fileLogger", DISPATCH_QUEUE_SERIAL) as dispatch_queue_t
    
    override init() {
        super.init()
        createLogFile()
    }
    
    func write(message: LogMessage) {
        dispatch_async(queue, { () -> Void in
            
            var fileHandler = NSFileHandle(forUpdatingAtPath: self.filePath())
            var truncationRequired = false
            
            let line = message.stringValue() + "\n"
            
            if let fileHandler = fileHandler {
                
                // First, do a check: will adding this string go beyond the size of
                // maxLogSize? If so, we'll need to truncate.
                // The truncation value of the file should be maxLogSize - the size of the incoming string.
                // We close the current file handle, re-create the log file, create a new file handle, and 
                // then write to the file.
                if self.shouldTruncateFile(fileHandler, stringToAdd: line, maxValue: self.maxLogSize) {
                    fileHandler.closeFile()
                    
                    self.destroyLogFile()
                    self.createLogFile()
                    
                    let newFileHandler = NSFileHandle(forUpdatingAtPath: self.filePath())
                    
                    if let newFileHandler = newFileHandler {
                        self.writeToFile(line, fileHandler: newFileHandler, maxValue: self.maxLogSize)
                        newFileHandler.closeFile()
                    }
                }
                else {
                    self.writeToFile(line, fileHandler: fileHandler, maxValue: self.maxLogSize)
                    fileHandler.closeFile()
                }
            }
        })
    }
    
    /*private*/ func shouldTruncateFile(fileHandler: NSFileHandle, stringToAdd: String, maxValue: Int) -> Bool {
        
        // Reset the file offset to 0 before checking the available data.
        fileHandler.seekToFileOffset(0)

        let projectedFileSize = fileHandler.availableData.length + stringToAdd.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        
        return projectedFileSize > maxValue
    }
    
    /*private*/ func writeToFile(string: String, fileHandler: NSFileHandle, maxValue: Int) {
        
        fileHandler.seekToEndOfFile()
        
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            fileHandler.writeData(data)
        }
    }
    
    /*private*/ func filePath() -> String {
        return NSFileManager.defaultManager().privateDataPathWithFilename(logFilename)
    }
    
    /*private*/ func createLogFile() {
        NSFileManager.defaultManager().createFileAtPath(filePath(), contents: nil, attributes: nil)
    }
    
    /*private*/ func destroyLogFile() {
        if NSFileManager.defaultManager().fileExistsAtPath(filePath()) {
			_ = try? NSFileManager.defaultManager().removeItemAtPath(filePath())
        }
    }

    func readLog() -> String {
		do {
			return try String(contentsOfFile: filePath(), encoding: NSUTF8StringEncoding)
		} catch _ as NSError {}
		
        return ""
    }
}
