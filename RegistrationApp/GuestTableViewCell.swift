//
//  GuestTableViewCell.swift
//  RegistrationApp
//
//  Created by Justin Cullen on 1/4/19.
//  Copyright © 2019 Justin Cullen. All rights reserved.
//

import UIKit

class GuestTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var constIdLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cellPhoneNumberLabel: UILabel!
    @IBOutlet weak var numberOfGuestLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var balanceDueLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var SidePanel: UIView!
    @IBOutlet weak var Top: UIView!
    @IBOutlet weak var Bot: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
