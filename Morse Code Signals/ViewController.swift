//
//  ViewController.swift
//  Morse Code Signals
//
//  Created by tbredemeier on 7/12/18.
//  Copyright © 2018 tbredemeier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signalView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var displayLabel: UILabel!

    var timer = Timer()
    var index = 0
    var pattern = ""
    let morseCode = ["A": ".-",
                     "B": "-...",
                     "C": ".-.-.",
                     "D": "-..",
                     "E": ".",
                     "F": "..-.",
                     "G": "--.",
                     "H": "....",
                     "I": "..",
                     "J": ".---",
                     "K": "-.-",
                     "L": ".-..",
                     "M": "--",
                     "N": "-.",
                     "O": "---",
                     "P": ".--.",
                     "Q": "--.-",
                     "R": ".-.",
                     "S": "...",
                     "T": "-",
                     "U": "..-",
                     "V": "...-",
                     "W": ".--",
                     "X": "-..-",
                     "Y": "-.--",
                     "Z": "--..",
                     "1": ".----",
                     "2": "..---",
                     "3": "...--",
                     "4": "....-",
                     "5": ".....",
                     "6": "-....",
                     "7": "--...",
                     "8": "---..",
                     "9": "----.",
                     "0": "-----"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func flashSignal(type: String) {
        var duration: Double!
        switch type {
        case ".":
            duration = 0.1
        case "-":
            duration = 0.3
        default:
            duration = 0.0
        }
        // turn the signal on
        signalView.backgroundColor = .white
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { (timer) in
            // turn the signal off
            self.signalView.backgroundColor = .black
            // wait one second
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.nextSignal), userInfo: nil, repeats: false)
        }
    }

    @objc func nextSignal() {
        if index < pattern.count {
            let pos = pattern.index(pattern.startIndex, offsetBy: index)
            flashSignal(type: String(pattern[pos]))
        }
        index += 1
    }

    @IBAction func onSendButtonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let phrase = textField.text!
        textField.resignFirstResponder()
        var pos = 0
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            if pos < phrase.count {
                let p = phrase.index(phrase.startIndex, offsetBy: pos)
                let letter = String(phrase[p]).uppercased()
                if let code = self.morseCode[letter] {
                    self.pattern = code
                    self.index = 0
                    self.displayLabel.text = letter
                    self.nextSignal()
                }
                pos += 1
            } else {
                timer.invalidate()
                self.displayLabel.text = ""
                self.textField.text = ""
                sender.isEnabled = true
            }
        }
    }
}

