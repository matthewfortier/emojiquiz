//
//  SecondViewController.swift
//  EmojiQuiz
//
//  Created by Matthew Fortier on 2/8/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit

class LeaderBoardViewController: UIViewController {
    @IBOutlet weak var LeaderBoard: UIStackView!
    
    var category = [String: Int]()
    
    override func viewDidAppear(_ animated: Bool) {
        loadScores(name: "movies")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadScores(name: String) {
        if (UserDefaults.standard.object(forKey: name) != nil) {
            category = UserDefaults.standard.dictionary(forKey: name) as! [String : Int]
            
            let scores = category.sorted(by: { $0.value > $1.value })
            
            if category.count > 3 {
                for i in 0..<3 {
                    let label = LeaderBoard.arrangedSubviews[i] as! UILabel
                    label.text = "\(Array(scores)[i].key) \(Array(scores)[i].value)"
                    label.isHidden = false
                }
            } else {
                for i in 0..<category.count {
                    let label = LeaderBoard.arrangedSubviews[i] as! UILabel
                    label.text = "\(Array(scores)[i].key) \(Array(scores)[i].value)"
                    label.isHidden = false
                }
            }
        } else {
            let emptyLabel: UILabel = LeaderBoard.arrangedSubviews[0] as! UILabel
            emptyLabel.text = "No scores reported"
        }
    }
    
    func resetLabels() {
        for label: UIView in LeaderBoard.arrangedSubviews {
            label.isHidden = true
        }
    }

    @IBAction func changeCategory(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 1) {
            resetLabels()
            loadScores(name: "sayings")
        } else {
            resetLabels()
            loadScores(name: "movies")
        }
    }
    
}

