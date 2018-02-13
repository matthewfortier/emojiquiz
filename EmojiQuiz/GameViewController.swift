//
//  GameViewController.swift
//  EmojiQuiz
//
//  Created by Matthew Fortier on 2/8/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit

extension String {
    
    //Enables replacement of the character at a specified position within a string
    func replace(_ index: Int, _ newChar: Character) -> String {
        var chars = Array(characters)
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    func indexDistance(of character: Character) -> Int? {
        guard let index = index(of: character) else { return nil }
        return distance(from: startIndex, to: index)
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)];
    }
}


class GameViewController: UIViewController {
    
    @IBOutlet weak var EmojiLabel: UILabel!
    @IBOutlet weak var AnswerLabel: UILabel!
    
    var currentAnswerString: String = ""
    var currentQuestionIndex: Int = 0
    
    @IBOutlet weak var Keyboard: UIStackView!
    
    var questions: [Question] = [] //= [Question("🌽🐶", "Corn Dog", "Thing"), Question("🦁👑", "Lion King", "Thing")]
    var numQuestions: Int = 0
    
    var category: String  = ""
    var incorrectGuesses: Int = 0
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        numQuestions = UserDefaults.standard.integer(forKey: "numQuestions")
        category = UserDefaults.standard.string(forKey: "category")!
        readPlist()
        setAnswersToDashes(0)
        
        EmojiLabel.text = questions[0].getQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func keyPress(_ sender: UIButton) {
        let label: String = (sender.titleLabel?.text)!
        
        sender.isEnabled = false
        sender.setTitleColor(.gray, for: UIControlState.normal)
        
        print(label)
        
        let uppercasedAnswer: String = questions[currentQuestionIndex].getAnswer().uppercased()
        let currentAnswer: String = questions[currentQuestionIndex].getAnswer()
        
        if (uppercasedAnswer.contains(label)) {
            
            for i in 0..<currentAnswer.count {
                
                let index = currentAnswer.index(currentAnswer.startIndex, offsetBy: i)
                
                if uppercasedAnswer[index] == Character(label) {
                    currentAnswerString = currentAnswerString.replace(i, currentAnswer[index])
                }
            }
            
            AnswerLabel.text = currentAnswerString
            
            if (!currentAnswerString.contains("-") && currentQuestionIndex == numQuestions - 1) {
                score += 1
                loadLeaderBoard()
            } else if (!currentAnswerString.contains("-") && currentQuestionIndex < numQuestions) {
                score += 1
                loadNextQuestion()
            }
        } else {
            incorrectGuesses += 1
            sender.setTitleColor(.red, for: UIControlState.normal)
            if incorrectGuesses == 3 {
                loadLeaderBoard()
            }
        }
    }
    
    func setAnswersToDashes(_ index: Int) {
        let y = questions[index].getAnswer().replacingOccurrences(of: "[a-zA-Z0-9]", with: "-", options: .regularExpression, range: nil)
        
        currentAnswerString = y
        AnswerLabel.text = y
    }
    
    func loadNextQuestion() {
        currentQuestionIndex += 1
        
        setAnswersToDashes(currentQuestionIndex)
        resetKeyboard()
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.EmojiLabel.alpha = CGFloat(0)
        }, completion: {
            (finished: Bool) -> Void in
            
            self.EmojiLabel.text = self.questions[self.currentQuestionIndex].getQuestion()
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.EmojiLabel.alpha = CGFloat(1)
            }, completion: nil)
        })
    }
    
    func loadLeaderBoard() {
        UserDefaults.standard.set(score, forKey: "score")
        performSegue(withIdentifier: "EndGame",
                     sender: self)
    }
    
    func checkCategory () {
        
        if category == "0" {
            category = "movies"
            print(category)
        }
        else if category == "1" {
    
            category = "sayings"
            print(category)
        }
        else {
            category = "ERROR"
        }
        
    }
    func readPlist () {
        var newQuestion : Question
        checkCategory()
        if let path = Bundle.main.path(forResource: category, ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                for item in 0..<Array(dict).count {
                    newQuestion = Question(Array(dict)[item].key, String(describing: Array(dict)[item].value), "Movies")
                    questions.append(newQuestion)
                }
            }
        }

    }
    
    func resetKeyboard() {
        for row: UIView in Keyboard.arrangedSubviews {
            for col in row.subviews {
                let button: UIButton = col as! UIButton
                button.isEnabled = true
                button.setTitleColor(UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1), for: UIControlState.normal)
            }
        }
    }
    
    /*S
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
