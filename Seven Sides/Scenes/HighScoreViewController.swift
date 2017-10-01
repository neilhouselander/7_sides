//
//  HighScoreViewController.swift
//  Seven Sides
//
//  Created by Neil Houselander on 01/10/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import UIKit

//MARK: To do
//thinking make global variables for each - but as dictionary - will also need to be user defaults so it remembers

class HighScoreViewController: UIViewController {

    @IBOutlet weak var namePicker: UIPickerView!
    
    @IBOutlet weak var firstScore: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var scondScore: UILabel!
    @IBOutlet weak var secondName: UILabel!
    @IBOutlet weak var thirdScore: UILabel!
    @IBOutlet weak var thirdName: UILabel!
    @IBOutlet weak var fourthScore: UILabel!
    @IBOutlet weak var fourthName: UILabel!
    @IBOutlet weak var fifthScore: UILabel!
    @IBOutlet weak var fifthName: UILabel!
    @IBOutlet weak var sixthScore: UILabel!
    @IBOutlet weak var sixthName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
