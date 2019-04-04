//
//  AllSetViewController.swift
//  RegistrationApp
//
//  Created by Justin Cullen on 2/13/19.
//  Copyright © 2019 Justin Cullen. All rights reserved.
//

import UIKit
import os.log

class AllSetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        returnHome()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 
    //Returning Home from All Set screen after a 3 second delay.
    private func returnHome(){
        os_log("Segue to Home screen from All Set screen.", log: OSLog.default, type: .debug)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let homeScreen = storyBoard.instantiateViewController(withIdentifier: "Home") as! HomeScreenViewController
            self.present(homeScreen, animated: true, completion: nil)
            
        }
    }
}
