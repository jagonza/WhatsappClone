//
//  InterfaceController.swift
//  ParseStarterProject WatchKit Extension
//
//  Created by Javier González Rojo on 9/8/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var warningLabel: WKInterfaceLabel!
    @IBOutlet weak var table: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        WKInterfaceController.openParentApplication(["content" : "isLoggedIn"], reply: { (reply, error) -> Void in
            
            if let loggedIn = reply["loggedIn"] as? String {
                
                if loggedIn == "true" {
                    WKInterfaceController.openParentApplication(["content":"getMessages"], reply: { (reply, error) -> Void in
                        
                        if let messages = reply["messages"] as? [String] {
                            self.table.setHidden(false)
                            self.table.setNumberOfRows(messages.count , withRowType: "tableRowCotroller")
                            
                            for (index, message) in enumerate(messages) {
                                let row = self.table.rowControllerAtIndex(index) as! TableRowController
                                row.rowLabel.setText(message)
                            }
                        }

                    })
                } else {
                    self.warningLabel.setHidden(false)
                }
                
            }
            
        })
    }
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
