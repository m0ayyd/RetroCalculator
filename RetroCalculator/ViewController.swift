//
//  ViewController.swift
//  RetroCalculator
//
//  Created by the Luckiest on 6/18/17.
//  Copyright © 2017 the Luckiest. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var btnSound: AVAudioPlayer!
    @IBOutlet weak var resultLbl: UILabel!
    
    enum Operation: String {
        case Divice = "/"
        case Multiply = "*"
        case Subtrac = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        resultLbl.text = "0"
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        if(sender.tag == 10){
            return
        }
        runningNumber += "\(sender.tag)"
        resultLbl.text = runningNumber
    }
    
    
    func playSound () {
        if btnSound.play() {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divice {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtrac {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                leftValStr = result
                resultLbl.text = result
            }
            
            currentOperation = operation
        } else {
            leftValStr = runningNumber
            runningNumber = ""
        }
    }
    
    @IBAction func onDividPressed (sender: Any) {
        processOperation(operation: .Divice)
    }
    @IBAction func onMultiplayPressed (sender: Any) {
        processOperation(operation: .Multiply)
    }
    @IBAction func onAddPressed (sender: Any) {
        processOperation(operation: .Add)
    }
    @IBAction func onSubtracPressed (sender: Any) {
        processOperation(operation: .Subtrac)
    }
    
    @IBAction func onEqualPressed (sender: Any) {
        processOperation(operation: currentOperation)
    }
    

}

