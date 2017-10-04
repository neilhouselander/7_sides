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

class HighScoreViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    

    @IBOutlet weak var firstScoreLabel: UILabel!
    @IBOutlet weak var secondScoreLabel: UILabel!
    @IBOutlet weak var thirdScoreLabel: UILabel!
    @IBOutlet weak var fourthScoreLabel: UILabel!
    @IBOutlet weak var fifthScoreLabel: UILabel!
    @IBOutlet weak var sixthScoreLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var thirdNameLabel: UILabel!
    @IBOutlet weak var fourthNameLabel: UILabel!
    @IBOutlet weak var fifthNameLabel: UILabel!
    @IBOutlet weak var sixthNameLabel: UILabel!
    
    @IBOutlet weak var initialPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialPicker.delegate = self
        initialPicker.dataSource = self
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Picker View Functions
    
    let pickerFont = UIFont(name: "Caviar Dreams", size: 25)
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return initialsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return initialsArray[row]

    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.font = UIFont(name: "Caviar Dreams", size: 25)
        pickerLabel.textAlignment = .center
        pickerLabel.text = initialsArray[row]
        pickerLabel.textColor = UIColor.white
        
        return pickerLabel
    }
    

    
    
}
