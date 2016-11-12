//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var hiddenWord = [Letter]()

    @IBOutlet weak var guessedLetter: UITextField!
    
    @IBOutlet weak var incorrectLetters: UILabel!
    
    @IBOutlet weak var phraseView: UILabel!
    
    @IBOutlet weak var hangManImage: UIImageView!
    
    var wordToUILabel : String = ""
    var incorrectLettersToUILabel : String = ""
    var numOfWordsToWin : Int = 0
    var incorrectNum = 0
    var winOrLose = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        
        numOfWordsToWin = (phrase?.characters.count)!
        
        hangManImage.image = #imageLiteral(resourceName: "hangman1.gif")
        
        for letter in (phrase?.characters)! {
            print(letter.description)
            if letter.description != " " {
                let hiddenLetter = Letter(hiddenLetter: "_", revealedLetter: letter.description, revealed: 0)
                self.hiddenWord.append(hiddenLetter)
                wordToUILabel += "_" + " "

                continue
            }
            let hiddenLetter = Letter(hiddenLetter: " ", revealedLetter: letter.description, revealed: 1)
            self.hiddenWord.append(hiddenLetter)
            wordToUILabel += " " + " "
            print(hiddenLetter.revealedLetter)
        }
        
        phraseView.text = wordToUILabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func guessedButtonPressed(_ sender: Any) {
        var numOfLetters = 0
        if winOrLose == 0 {
            wordToUILabel = ""
            var checkLetterFound = 0
            for letter in self.hiddenWord {
                if letter.revealed == 1 {
                    wordToUILabel += letter.revealedLetter + " "
                    numOfLetters += 1
                }
                else if letter.revealedLetter  == guessedLetter.text?.capitalized {
                    letter.revealed = 1
                    checkLetterFound = 1
                    numOfLetters += 1
                    wordToUILabel += letter.revealedLetter + " "
                } else {
                    wordToUILabel += letter.hiddenLetter + " "
                }
            }
            if checkLetterFound == 0 {
                incorrectLettersToUILabel += guessedLetter.text! + " "
                incorrectNum += 1
                
            }
            phraseView.text = wordToUILabel
            incorrectLetters.text = incorrectLettersToUILabel
            hangManUpdate()
            
            if numOfLetters == numOfWordsToWin {
                let alert = UIAlertController(title: "Hangman", message: "YOU WIN", preferredStyle: UIAlertControllerStyle.alert)
                
                
                self.present(alert, animated: true, completion: nil)
                alert.dismiss(animated: true, completion: nil)

            }
        }
    }
    
    func hangManUpdate() {
        switch incorrectNum {
        case 0:
            hangManImage.image = #imageLiteral(resourceName: "hangman1.gif")
        case 1:
            hangManImage.image = #imageLiteral(resourceName: "hangman2.gif")
        case 2:
            hangManImage.image = #imageLiteral(resourceName: "hangman3.gif")
        case 3:
            hangManImage.image = #imageLiteral(resourceName: "hangman4.gif")
        case 4:
            hangManImage.image = #imageLiteral(resourceName: "hangman5.gif")
        case 5:
            hangManImage.image = #imageLiteral(resourceName: "hangman6.gif")
        default:
            hangManImage.image = #imageLiteral(resourceName: "hangman7.gif")
            winOrLose = 1
            
            let alert = UIAlertController(title: "Hangman", message: "YOU LOSE", preferredStyle: UIAlertControllerStyle.alert)
            
            
            self.present(alert, animated: true, completion: nil)
            
            alert.dismiss(animated: true, completion: nil)
            

        }
    }
    
    
    @IBAction func newGame(_ sender: Any) {
        hangManImage.image = #imageLiteral(resourceName: "hangman1.gif")
        hiddenWord.removeAll()
        
        wordToUILabel = ""
        incorrectLettersToUILabel = ""
        numOfWordsToWin = 0
        incorrectNum = 0
        winOrLose = 0
        
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        
        numOfWordsToWin = (phrase?.characters.count)!
        
        for letter in (phrase?.characters)! {
            print(letter.description)
            if letter.description != " " {
                let hiddenLetter = Letter(hiddenLetter: "_", revealedLetter: letter.description, revealed: 0)
                self.hiddenWord.append(hiddenLetter)
                wordToUILabel += "_" + " "
                
                continue
            }
            let hiddenLetter = Letter(hiddenLetter: " ", revealedLetter: letter.description, revealed: 1)
            self.hiddenWord.append(hiddenLetter)
            wordToUILabel += " " + " "
            print(hiddenLetter.revealedLetter)
        }
        
        phraseView.text = wordToUILabel
        incorrectLetters.text = incorrectLettersToUILabel
        hangManUpdate()
        
        
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
