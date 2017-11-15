//
//  ViewController.swift
//  1112 猜數字
//
//  Created by 泳逸 李 on 2017/11/12.
//  Copyright © 2017年 yungyili. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    var minNumber = 1
    var maxNumber = 100
    var leftTimes = 6
    var answer = GKRandomSource.sharedRandom().nextInt(upperBound: 100) + 1
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var leftTimesLabel: UILabel!
    
    @IBAction func playAgain(_ sender: UIButton) {
        minNumber = 1
        maxNumber = 100
        leftTimes = 6
        numberLabel.text = "請輸入一個\(minNumber)~\(maxNumber)的整數"
        inputTextField.text = ""
        myImage.image = UIImage(named: "bomb")
        leftTimesLabel.text = "剩餘\(leftTimes)次"
        answer = GKRandomSource.sharedRandom().nextInt(upperBound: 100) + 1
        guess.isEnabled = true
        guess.alpha = 1
        inputTextField.isEnabled = true
        inputTextField.placeholder = "0"
        inputTextField.becomeFirstResponder()
        inputTextField.isHidden = false
        popUpStartAlert()
    }
    
    @IBOutlet weak var guess: UIButton!
    @IBAction func guess(_ sender: UIButton) {
        if let inputText = inputTextField.text{
            if let inputNumber = Int(inputText){
                if inputTextField.text == nil{
                numberLabel.text = "麻煩請輸入一個\(minNumber)~\(maxNumber)的整數"
                inputTextField.text = ""
                }else if inputNumber >= maxNumber{
                numberLabel.text = "數字太大，請輸入\(minNumber)~\(maxNumber)的整數"
                inputTextField.text = ""
                }else if inputNumber <= minNumber{
                numberLabel.text = "數字太小，請輸入\(minNumber)~\(maxNumber)的整數"
                inputTextField.text = ""
            }else{
                if inputNumber < answer{
                    minNumber = inputNumber
                    numberLabel.text = "請猜一個\(minNumber)~\(maxNumber)之間的整數"
                    checkHowManyTimesLeft()
                    inputTextField.text = ""
                }else if inputNumber > answer{
                    maxNumber = inputNumber
                    numberLabel.text = "請猜一個\(minNumber)~\(maxNumber)之間的整數"
                    checkHowManyTimesLeft()
                    inputTextField.text = ""
                }else if inputNumber == answer{
                    numberLabel.text = "[恭喜成功拆除了炸彈]"
                    myImage.image = UIImage(named: "safe")
                    inputTextField.text = ""
                    guess.isEnabled = false
                    guess.alpha = 0
                    inputTextField.isEnabled = false
                    inputTextField.placeholder = nil
                    inputTextField.resignFirstResponder()
                    inputTextField.isHidden = true
                    popUpSuccessAlert()
                    }
                }
            }
        }
    }
    
    func popUpBoomAlert(){
        let myAlert = UIAlertController(title: "遊戲結束", message: "拆彈密碼為\(answer)，繼續玩請按Play Again按鈕", preferredStyle: .alert)
        let endAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        myAlert.addAction(endAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    func popUpSuccessAlert(){
        let myAlert = UIAlertController(title: "遊戲結束", message: "繼續玩請按Play Again", preferredStyle: .alert)
        let endAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        myAlert.addAction(endAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    func popUpStartAlert(){
        let Alert = UIAlertController(title: "遊戲開始", message: "請將數字輸入於文字框後按下GO", preferredStyle: .alert)
        let startAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        Alert.addAction(startAction)
        present(Alert, animated: true, completion: nil)
    }
    
   
    func checkHowManyTimesLeft(){
        if leftTimes > 1{
            leftTimes = leftTimes - 1
            leftTimesLabel.text = "剩餘\(leftTimes)次"
        }else{
            if leftTimes == 1{
            leftTimesLabel.text = "剩餘\(leftTimes - 1)次"
            numberLabel.text = "[爆炸啦!!]"
            myImage.image = UIImage(named: "boom")
            guess.isEnabled = false
            guess.alpha = 0
            inputTextField.isEnabled = false
            inputTextField.placeholder = nil
            inputTextField.resignFirstResponder()
            inputTextField.isHidden = true
            popUpBoomAlert()
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
   
    override func viewDidAppear(_ animated: Bool) {
        popUpStartAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.becomeFirstResponder()
        inputTextField.placeholder = "0"
        leftTimesLabel.text = "剩餘\(leftTimes)次"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

