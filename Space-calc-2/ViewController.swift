//
//  ViewController.swift
//  Space-calc-2
//
//  Created by Jonatan Knudsen on 30/12/2015.
//  Copyright © 2015 Jonatan Knudsen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftNumber = ""
    var rightNumber = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let soundPath = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: soundPath!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(op: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            rightNumber = runningNumber
            runningNumber = ""
            if rightNumber != "" {
                if currentOperation == Operation.Divide {
                    result = "\(Double(leftNumber)! / Double(rightNumber)!)"
                } else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftNumber)! * Double(rightNumber)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftNumber)! + Double(rightNumber)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftNumber)! - Double(rightNumber)!)"
                }
                leftNumber = result
                outputLbl.text = result
            }
            currentOperation = op
        } else {
            leftNumber = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func updateLbl() {
        outputLbl.text = result
    }
    
    @IBAction func onNumberPressed(btn: UIButton) {
        playSound()
        if btn.tag != 10 {
            runningNumber += "\(btn.tag)"
        } else {
            runningNumber += "."
        }
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        currentOperation = Operation.Empty
        leftNumber = ""
        rightNumber = ""
        runningNumber = ""
        outputLbl.text = "0"
    }
}

