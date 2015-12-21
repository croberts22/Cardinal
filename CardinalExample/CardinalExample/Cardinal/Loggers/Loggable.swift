//
//  Loggable.swift
//  Cardinal
//
//  Created by Corey Roberts.
//

@objc protocol Loggable {
    var minimumToleranceLevel: CardinalSeverity { get set }
    var queue: dispatch_queue_t { get }
    func write(message: LogMessage)
}