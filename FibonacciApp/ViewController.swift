//
//  ViewController.swift
//  FibonacciApp
//
//  Created by AnishG on 11/3/19.
//  Copyright © 2019 playground. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    var seeds: Int = 100
    var ratio: Double = 1.61803398875
    @IBOutlet weak var fibonacciSKView: SKView!
    @IBOutlet weak var seedNumber: UILabel!
    @IBAction func increaseRatio(_ sender: UIStepper) {
        ratio = Double(sender.value)
        print("sender:\(sender.value)")
        //print("Description: \(ratio?.description)")
        ratioTextField.text = String(ratio)
        fib.reset()
        fib.start(seedNumber: seeds, ratio: ratio)
        print("seeds: \(seeds)")
    }
    func roundRatio() {
        let splitRatio = ratioTextField.text?.split(separator: ".")
        if let splitRatioArray = splitRatio {
            let factor = splitRatioArray[1].count
            if let doubleRatio = Double(ratioTextField.text ?? "1.61803398875") {
                ratioTextField.text = String(round(doubleRatio * pow(10.0, Double(factor)))/pow(10.0, Double(factor)))
            }
        }
        
    }
    @IBOutlet weak var ratioIncrement: UIStepper!
    var fib = FibonacciScene()
    @IBOutlet weak var ratioTextField: UITextField!
    @IBOutlet weak var incrementField: UITextField!
    @IBOutlet weak var seedTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ratioTextField.delegate = self
        seedTextField.delegate = self
        incrementField.delegate = self
        ratioIncrement.value = ratio ?? 0
        ratioTextField.text = String(ratio)
        seedTextField.text = String(seeds)
        if let scene = SKScene(fileNamed: "FibonacciScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFit
            fib = scene as! FibonacciScene
            // Present the scene
            fibonacciSKView.presentScene(scene)
            fib.start(seedNumber: seeds, ratio: ratio)
        }
    }
}
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField)
        self.view.endEditing(true)
        if let seedText = seedTextField.text, let ratioText = ratioTextField.text {
            seeds = Int(seedText) ?? seeds
            ratio = Double(ratioText) ?? ratio
        }
        
        if let increase = incrementField.text {
            let increment = Double(increase)
            ratioIncrement.stepValue = increment ?? 0.001
        }
        ratioIncrement.value = ratio ?? 0
        fib.start(seedNumber: seeds, ratio: ratio)
        return true
    }
}


