//
//  HighScoreViewController.swift
//  Seven Sides
//
//  Created by Neil Houselander on 01/10/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import UIKit

//MARK: To do
//load up current names & scores from High Scores Array: DONE
//enter your initials: DONE
//add this & score to a new instance of ""Players"
//append this to the hiScoreArray
//sort the array
//drop off the last-- only if more than 6 in the array
//update labels
//need to be abe to dismiss this view when finished looking at scores

//EXTRAS
//dismiss picker view
//hide the input stuff
//add way of seeing hi scores without having to enter anything
//once sorte this - need to use user defaults to store so persistant?? how to do that !

//how to sort an array
// players.sort(by: {$0.score > $1.score})

class HighScoreViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var initialsOutputTextField: UITextField!
    
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
    
    var initialsForThisHighScore:String?
    
    var hiScoreArray:[Players] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialPicker.delegate = self
        initialPicker.dataSource = self

        //dummy array
        createDummyArray()
        updateLabelsWithNewArrayValues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //need this view to unhide enter button, picker view & text field as will have been hidden when last hi score entered
        //load up high scores from array
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        //add to array
        //sort array
        //drop of last (if more than 6)
        //update all labels
        //dismiss pickerview
        //hide input bits & enter label
        
        
    }
    
    func createDummyArray() {
        
        let player1 = Players(initials: "AA1", score: 1)
        let player2 = Players(initials: "AA2", score: 2)
        let player3 = Players(initials: "AA3", score: 3)
        let player4 = Players(initials: "AA4", score: 4)
        let player5 = Players(initials: "AA5", score: 5)
        let player6 = Players(initials: "AA6", score: 6)
        
        hiScoreArray = [player1, player2, player3, player4, player5, player6]
    }
    
    func updateLabelsWithNewArrayValues() {
        
        firstScoreLabel.text = String(hiScoreArray[0].score)
        firstNameLabel.text = hiScoreArray[0].initials
        
        secondScoreLabel.text = String(hiScoreArray[1].score)
        secondNameLabel.text = hiScoreArray[1].initials
        
        thirdScoreLabel.text = String(hiScoreArray[2].score)
        thirdNameLabel.text = hiScoreArray[2].initials
        
        fourthScoreLabel.text = String(hiScoreArray[3].score)
        fourthNameLabel.text = hiScoreArray[3].initials
        
        fifthScoreLabel.text = String(hiScoreArray[4].score)
        fifthNameLabel.text = hiScoreArray[4].initials
        
        sixthScoreLabel.text = String(hiScoreArray[5].score)
        sixthNameLabel.text = hiScoreArray[5].initials
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if initialsForThisHighScore == nil {
            
        initialsForThisHighScore = initialsArray[row]
        initialsOutputTextField.text = initialsForThisHighScore
        }
        else {
            if initialsForThisHighScore?.count != 3 {
                
            initialsForThisHighScore?.append(initialsArray[row])
            initialsOutputTextField.text = initialsForThisHighScore
            }
        }
   }
    
    
}
