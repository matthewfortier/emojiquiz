//
//  EndGameViewController.swift
//  EmojiQuiz
//
//  Created by Matthew Fortier on 2/13/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var Name: UITextField!
    
    var sayings = [String: Int]()
    var movies = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Score.text = String(UserDefaults.standard.integer(forKey: "score"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitScore(_ sender: UIButton) {
        if (UserDefaults.standard.integer(forKey: "category") == 0) {
            
            if (UserDefaults.standard.object(forKey: "movies") != nil) {
                movies = UserDefaults.standard.dictionary(forKey: "movies") as! [String : Int]
            }
            
            movies[Name.text!] = UserDefaults.standard.integer(forKey: "score")
            
            UserDefaults.standard.set(movies, forKey: "movies")
        } else {
            
            if (UserDefaults.standard.object(forKey: "sayings") != nil) {
                sayings = UserDefaults.standard.dictionary(forKey: "sayings") as! [String : Int]
            }
            
            sayings[Name.text!] = UserDefaults.standard.integer(forKey: "score")
            
            UserDefaults.standard.set(sayings, forKey: "sayings")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
