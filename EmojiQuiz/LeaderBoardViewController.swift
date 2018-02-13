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
    
    var sayings = [String: Int]()
    var movies = [String: Int]()
    
    override func viewDidAppear(_ animated: Bool) {
        sayings = UserDefaults.standard.dictionary(forKey: "sayings") as! [String : Int]
        
        let scores = sayings.sorted(by: { $0.value > $1.value })
        
        if sayings.count > 3 {
            for i in 0..<3 {
                let label = LeaderBoard.arrangedSubviews[i] as! UILabel
                label.text = "\(Array(scores)[i].key) \(Array(scores)[i].value)"
            }
        } else {
            for i in 0..<sayings.count {
                let label = LeaderBoard.arrangedSubviews[i] as! UILabel
                label.text = "\(Array(scores)[i].key) \(Array(scores)[i].value)"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

