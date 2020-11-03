//
//  ViewController.swift
//  Project2
//
//  Created by Anselm Jade Jamig on 11/1/20.
//

import UIKit
import Fireworks

class ViewController: UIViewController {
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = ["estonia", "france", "germany",
                     "ireland", "italy", "monaco",
                     "nigeria", "poland", "russia",
                     "spain", "uk", "us"]  
    var score = 0
    var correctAnswer = 0
    var questionNumber = 0
    var fireWork = ClassicFireworkController()
    var fountain = FountainFireworkController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavScoreLabel(score)
        
        button1.tag = 0
        button2.tag = 1
        button3.tag = 2
        
        makeBorder(button1)
        makeBorder(button2)
        makeBorder(button3)
        askQuestion()
        
    }
    
    func askQuestion(){
        questionNumber += 1
        enableButtons()
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        navigationItem.title = countries[correctAnswer].uppercased()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    func makeBorder(_ button: UIButton){
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func buttonTyped(_ sender: UIButton) {
        var title: String
        disableButtons()
        
        if sender.tag == correctAnswer{
            title = "CORRECT!"
            score += 1
            fireWork.addFireworks(count: 2, sparks: 8, around: sender, sparkSize: CGSize(width: 8, height: 8))
            makeNavScoreLabel(score)
            updateLabel(title, true)
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            updateLabel(title, false)
        }
        
        
        
        //        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        //        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (alertAction) in
        //            self.askQuestion()
        //        }))
        //        present(ac, animated: true)
    }
    
    func makeNavScoreLabel(_ score: Int){
        let titleLabel = UILabel()
        titleLabel.text = "Score: \(score)"
        titleLabel.sizeToFit()
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func disableButtons(){
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        
        button1.isOpaque = true
        button2.isOpaque = true
        button3.isOpaque = true
        
    }
    func enableButtons(){
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
    }
    
    func updateLabel(_ text: String, _ isCorrect: Bool){
        answerLabel.text = text
        if isCorrect{
            answerLabel.textColor = UIColor(named: "sysGreen")
            checkIfEndQuiz(0.5)
        } else {
            answerLabel.textColor = UIColor(named: "sysRedd")
            checkIfEndQuiz(0.8)
        }
    }
    
    func checkIfEndQuiz(_ seconds: Double){
        if questionNumber < 10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: {
                self.answerLabel.text = ""
                self.askQuestion()
            })
        } else {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (alertAction) in
                self.resetQuiz()
            }))
            present(ac, animated: true)
        }
    }
    
    func resetQuiz(){
        enableButtons()
        questionNumber = 0
        score = 0
        askQuestion()
        answerLabel.text = ""
        makeNavScoreLabel(score)
    }
    
    
}

