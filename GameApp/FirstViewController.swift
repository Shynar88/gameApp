//
//  FirstViewController.swift
//  GameApp
//
//  Created by Шынар Торехан on 29/06/2018.
//  Copyright © 2018 Shynar Torekhan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, GamerDelegate {
    let userDefaults = UserDefaults.standard
    @IBOutlet weak var nameLabel: UILabel!
    func passGamerData(data: [String]) {
        nameLabel.text = data[0]
        scoreLabel.text = data[1]
    }
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        let data = userDefaults.object(forKey: "Data") as? [String] ?? ["Last Player", "0"]
        nameLabel.text = data[0]
        scoreLabel.text = data[1]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    var difficulty = [0, 0]
    
    @IBAction func button1(_ sender: UIButton) {
        button1.isSelected = true;
        button2.isSelected = false;
        button3.isSelected = false;
        difficulty = [8, 1]
    }
    @IBAction func button2(_ sender: UIButton) {
        button1.isSelected = false;
        button2.isSelected = true;
        button3.isSelected = false;
        difficulty = [89, 10]
    }
    @IBAction func button3(_ sender: Any) {
        button1.isSelected = false;
        button2.isSelected = false;
        button3.isSelected = true;
        difficulty = [899, 100]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is GameViewController
        {
            let vc = segue.destination as! GameViewController
            vc.delegate = self
            vc.difficulty = difficulty
        }
    }
    
}

