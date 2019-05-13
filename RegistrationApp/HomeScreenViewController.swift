//
//  HomeScreenViewController.swift
//  RegistrationApp
//
//  Created by Justin Cullen on 1/29/19.
//  Copyright © 2019 Justin Cullen. All rights reserved.
//

import UIKit
import os.log

class HomeScreenViewController: UIViewController {
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? ""){
        case "NewGuest":
        os_log("Segue to New Guest Screen from Home screen.", log: OSLog.default, type: .debug)
        
        case "Register":
            os_log("Segue to Guest List screen from Home Screen.", log: OSLog.default, type: .debug)
            
        case "ArrivedGuests":
            os_log("Segue to Arrived List screen from Home Screen.", log: OSLog.default, type: .debug)
            
        default:
            fatalError("Unexpected Segue Indentifier; \(String(describing: segue.identifier))")
        }
       
    }
    

}
