//
//  SecondViewController.swift
//  GameApp
//
//  Created by Шынар Торехан on 29/06/2018.
//  Copyright © 2018 Shynar Torekhan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setColorOfLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    let colorDict = ["Black":UIColor.black, "White":UIColor.white, "Yellow":UIColor.yellow, "Blue":UIColor.blue, "Green":UIColor.green, "Red":UIColor.red, "Purple":UIColor.purple]
    let uiColorList = [UIColor.black, UIColor.white, UIColor.yellow, UIColor.blue, UIColor.green, UIColor.red, UIColor.purple]
    let colorList = ["Black", "White", "Yellow", "Blue", "Green", "Red", "Purple"]
    
    @IBAction func falseButtonPressed(_ sender: UIButton) {
        let currentColor = colorLabel.backgroundColor
        let currentText = colorLabel.text!
        if currentColor != colorDict[currentText]{
            score += 1
            scoreLabel.text = "Score: \(score)"
        } else {
            score -= 1
            scoreLabel.text = "Score: \(score)"
            if score<0{
                showAlert()
            }
        }
        setColorOfLabel()
    }
    
    @IBAction func trueButtonPressed(_ sender: UIButton) {
        let currentColor = colorLabel.backgroundColor
        let currentText = colorLabel.text!
        if currentColor == colorDict[currentText]{
            score += 1
            scoreLabel.text = "Score: \(score)"
        } else {
            score -= 1
            scoreLabel.text = "Score: \(score)"
            if score<0{
                showAlert()
            }
        }
        setColorOfLabel()
    }
    
    func setColorOfLabel(){
        let randomUIColor = uiColorList[Int(arc4random_uniform(UInt32(colorDict.count)))]
        let randomColor = colorList[Int(arc4random_uniform(UInt32(colorDict.count)))]
        colorLabel.text = randomColor
        colorLabel.backgroundColor = randomUIColor
    }
    
    func showAlert(){
        let ac = UIAlertController(title: "Game is over!", message: "Your score is: \(score)", preferredStyle: .alert)
        ac.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter your name"
        })
        let acAction = UIAlertAction(title: "OK", style: .default, handler:{ (action) in
            ac.dismiss(animated: true, completion: nil)
            self.score = 0
            self.setColorOfLabel()
            self.scoreLabel.text = "Score: \(self.score)"
        })
        ac.addAction(acAction)
        present(ac, animated: true, completion: nil)
    }
}

