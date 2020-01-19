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
    var seeds: Int?
    var ratio: Double? = 0.1
    @IBOutlet weak var fibonacciSKView: SKView!
    @IBOutlet weak var seedNumber: UILabel!
    @IBAction func increaseRatio(_ sender: UIStepper) {
        ratio? += Double(sender.stepValue)
        print("sender:\(sender.value)")
        //print("Description: \(ratio?.description)")
        ratioTextField.text = ratio?.description
        if let ratio = ratio, let seeds = seeds {
            fib.reset()
            fib.start(seedNumber: seeds, ratio: ratio)
            print("seeds: \(seeds)")
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
        if let scene = SKScene(fileNamed: "FibonacciScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFit
            fib = scene as! FibonacciScene
            // Present the scene
            fibonacciSKView.presentScene(scene)
        }
    }
}
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField)
        self.view.endEditing(true)
        seeds = Int(seedTextField.text ?? "10")
        ratio = Double(ratioTextField.text ?? "0.1")
            let increment = Double(incrementField.text ?? "0.001")
        ratioIncrement.stepValue = increment ?? 0.001
        if let seeds = seeds, let ratio = ratio {
            fib.start(seedNumber: seeds, ratio: ratio)
        }
        return true
    }
}


