//
//  FirstViewController.swift
//  EmojiQuiz
//
//  Created by Matthew Fortier on 2/8/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit

class ConfigureViewController: UIViewController {

    @IBOutlet weak var questionStepper: UIStepper!
    @IBOutlet weak var questions: UILabel!
    
    @IBOutlet weak var categorySelector: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeStep(_ sender: UIStepper) {
        questions.text = String(UInt(sender.value))
    }
    
    @IBAction func play(_ sender: UIButton) {
        UserDefaults.standard.set(categorySelector.selectedSegmentIndex, forKey: "category")
        UserDefaults.standard.set(UInt(questions.text!), forKey: "numQuestions")
        
        
    }
}

