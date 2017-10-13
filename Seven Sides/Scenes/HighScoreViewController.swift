//
//  HighScoreViewController.swift
//  Seven Sides
//
//  Created by Neil Houselander on 01/10/2017.
//  Copyright © 2017 Neil Houselander. All rights reserved.
//

import UIKit

//MARK: To do
//DONE load up current names & scores from High Scores Array: DONE
//DONE enter your initials: DONE
//DONE add this & score to a new instance of ""Players" DONE
//DONE append this to the hiScoreArray DONE
//DONE sort the array DONE
//DONE drop off the last-- only if more than 6 in the array DONE
//DONE update labels DONE
//need to be abe to dismiss this view when finished looking at scores
//need a return to start once intials entered

//EXTRAS
//add way of seeing hi scores without having to enter anything -- or if your score - not better than lowest hi score then just show scores & flip input off (alpha 0)
//once sorted this - need to use user defaults to store so persistant?? how to do that !
//tidy up picker view entry - currently any wheel adds /appends - need each picker wheel to just do that initial/character


class HighScoreViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: outlets
    
    @IBOutlet weak var initialsOutputTextField: UITextField!
    @IBOutlet weak var enterButtonOutlet: UIButton!
    @IBOutlet weak var addInitialsLabel: UILabel!
    @IBOutlet weak var tapToPlayAgainOutlet: UIButton!
    
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
    
    //MARK: constants & variable declations
    
    var initialsForThisHighScore:String?
    
    let pickerFont = UIFont(name: "Caviar Dreams", size: 25)
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initialPicker.delegate = self
        initialPicker.dataSource = self

        
        createDummyArray()
        updateLabelsWithArrayValues()
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
        
        if let initialsToAdd = initialsForThisHighScore {
            
            let scoreToAdd = 100
            
            let thisPlayer = Players(initials: initialsToAdd, score: scoreToAdd)
            
            hiScoreArray.append(thisPlayer)
           
            
            //sort array
            hiScoreArray.sort(by: {$0.score > $1.score})
            
            
            //drop of last (if more than 6)
            if hiScoreArray.count > 6 {
                
                hiScoreArray.removeLast()
                
            }
            
            //update all labels
            updateLabelsWithArrayValues()
            
            //hide input
            flipLabelsOnOff()
            
            //add tap to play again button
            tapToPlayAgainOutlet.alpha = 1
            

            
        }

    }
    
    @IBAction func tapToPlayAgainButton(_ sender: UIButton) {
        
        let sceneToMoveTo = GameScene()
        
        
        
    }
    
    
    func flipLabelsOnOff(){
        
        if initialPicker.alpha == 1 {
            initialPicker.alpha = 0
            initialsOutputTextField.alpha = 0
            enterButtonOutlet.alpha = 0
            addInitialsLabel.alpha = 0

        } else {
            initialPicker.alpha = 1
            initialsOutputTextField.alpha = 1
            enterButtonOutlet.alpha = 1
            addInitialsLabel.alpha = 1
        }
    }
    
    //dummy array so it has value & no NIL entries will set this all to spaces & 0's before final implementation
    func createDummyArray() {
        
        let player1 = Players(initials: "AA1", score: 1)
        let player2 = Players(initials: "AA2", score: 2)
        let player3 = Players(initials: "AA3", score: 3)
        let player4 = Players(initials: "AA4", score: 4)
        let player5 = Players(initials: "AA5", score: 5)
        let player6 = Players(initials: "AA6", score: 6)
        
        hiScoreArray = [player1, player2, player3, player4, player5, player6]
    }
    
    func updateLabelsWithArrayValues() {
        
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
    
    
    //MARK: Picker View Functions
    
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
