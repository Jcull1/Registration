//
//  ArrivedGuestTableViewCell.swift
//  RegistrationApp
//
//  Created by Justin Cullen on 3/21/19.
//  Copyright © 2019 Justin Cullen. All rights reserved.
//

import UIKit

class ArrivedGuestTableViewCell: UITableViewCell {
    @IBOutlet weak var arrivedConstID: UILabel!
    @IBOutlet weak var arrivedFirstName: UILabel!
    @IBOutlet weak var arrivedLastName: UILabel!
    @IBOutlet weak var arrivedEmail: UILabel!
    @IBOutlet weak var arrivedPhoneNumber: UILabel!
    @IBOutlet weak var arrivedGuestOf: UILabel!
    @IBOutlet weak var arrivedNumber: UILabel!
    @IBOutlet weak var arrivedBalanceDue: UILabel!
    @IBOutlet weak var arrivedFront: UIView!
    @IBOutlet weak var arrivedBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
