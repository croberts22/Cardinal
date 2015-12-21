//
//  SwiftViewController.swift
//  CardinalExample
//
//  Created by Corey Roberts on 11/28/15.
//  Copyright © 2015 Corey Roberts. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    @IBAction func logButtonPressed(sender: AnyObject) {
        Log.debug("Logging a debug message.")
        Log.debug(.UserInterface, "Use categories (such as .UserInterface) to highlight events in your logger.")
    }
    
    @IBAction func infoButtonPressed(sender: AnyObject) {
        Log.info("Logging an info message.")
        Log.info(.UserInterface, "Use categories (such as .UserInterface) to highlight events in your logger.")
    }
    
    @IBAction func warningButtonPressed(sender: AnyObject) {
        Log.warning("Logging a warning message.")
        Log.warning(.UserInterface, "Use categories (such as .UserInterface) to highlight events in your logger.")
    }
    
    @IBAction func errorButtonPressed(sender: AnyObject) {
        Log.error("Logging an error message.")
        Log.error(.UserInterface, "Use categories (such as .UserInterface) to highlight events in your logger.")
    }

}
