//
//  Loggable.swift
//  iMapMy3
//
//  Created by Roberts, Corey on 7/14/15.
//  Copyright (c) 2015 MapMyFitness. All rights reserved.
//

@objc protocol Loggable {
    var minimumToleranceLevel: UALoggerSeverityLevel { get set }
    var queue: dispatch_queue_t { get }
    func write(message: LogMessage)
}