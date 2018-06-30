//
//  GameViewController.swift
//  GameApp
//
//  Created by Шынар Торехан on 29/06/2018.
//  Copyright © 2018 Shynar Torekhan. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    let userDefaults = UserDefaults.standard
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var bottomView: UILabel!
    @IBOutlet weak var answerField: UITextField!
    var difficulty = [Int]()
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if (x*y) == Int(answerField.text!){
            score += 1
            speed /= 2
            scoreLabel.text = "Score: \(score)"
            newQuestion()
            timer2?.invalidate()
            timer2 = Timer.scheduledTimer(timeInterval: speed, target: self, selector: #selector(moveQuestionLabel), userInfo: nil, repeats: true)
        }
        else{
            score -= 1
            speed *= 2
            scoreLabel.text = "Score: \(score)"
            newQuestion()
            timer2?.invalidate()
            timer2 = Timer.scheduledTimer(timeInterval: speed, target: self, selector: #selector(moveQuestionLabel), userInfo: nil, repeats: true)
        }
        answerField.text = nil
    }
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        timer1 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: speed, target: self, selector: #selector(moveQuestionLabel), userInfo: nil, repeats: true)
        
        newQuestion()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var x = 0
    var y = 0
    var score = 0
    var speed = 0.2
    var time = 10
    var timer1: Timer?
    var timer2: Timer?
    weak var delegate: GamerDelegate?
    @objc func moveQuestionLabel() {
        if(questionLabel.center.y >= bottomView.center.y) {
            newQuestion()
        }
        UIView.animate(withDuration: 0.2) {
            self.questionLabel.center.y += CGFloat(5)
        }
    }
    
    func showAlert(){
        let ac = UIAlertController(title: "Game is over!", message: "Your score is: \(score)", preferredStyle: .alert)
        ac.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter your name"
        })
        let acAction = UIAlertAction(title: "OK", style: .default, handler:{ (action) in
            self.delegate?.passGamerData(data: [(ac.textFields?[0].text)!, String(self.score)])
            self.userDefaults.set([(ac.textFields?[0].text)!, String(self.score)], forKey: "Data")
           self.navigationController?.popViewController(animated: true)
//            self.navigationController?.dismiss(animated: true, completion: nil)
        })
        ac.addAction(acAction)
        present(ac, animated: true, completion: nil)
    }
    
    func newQuestion() {
        x = Int(arc4random_uniform(UInt32(difficulty[0]))) + difficulty[1]
        y = Int(arc4random_uniform(9) + 1)
        questionLabel.text = "\(x) x \(y) ="
        questionLabel.center.y = 50
    }
    
    @objc func updateTime(){
        time -= 1
        timerLabel.text = "Time left: \(time) seconds"
        if time == 0 {
            timer1!.invalidate()
            timer2!.invalidate()
            showAlert()
            questionLabel.text = nil
        }
    }
}

protocol GamerDelegate: class {
    func passGamerData(data: [String])
}
