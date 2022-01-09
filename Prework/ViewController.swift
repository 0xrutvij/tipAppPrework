//
//  ViewController.swift
//  Prework
//
//  Created by Rutvij Shah on 1/8/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipPercentLabel: UILabel!

    
    @IBAction func otherTipPercent(_ sender: Any) {
        
        let tipPercentIdx = tipControl.selectedSegmentIndex
        let tipPercentages = [15, 18, 20]
        
        if tipPercentIdx == 3 {
            tipSlider.isEnabled = true
        }
        else {
            tipSlider.isEnabled = false
            tipSlider.value = Float(tipPercentages[tipPercentIdx])
            tipValueChanged(sender)
        }
        
    }
    
    @IBAction func tipValueChanged(_ sender: Any) {
        defer {
            tipPercentLabel.text = String(format: "%d%%", Int(tipSlider.value))
        }
        calcTip(sender)
        
    }
    
    
    @IBAction func calcTip(_ sender: Any) {
        let billAmt = Float(billAmountTextField.text!) ?? 0
        
        let sliderPercent = Int(tipSlider.value)
        
        let tip = billAmt * Float(sliderPercent) / 100.0
        
        let total = billAmt + tip
        
        tipAmountLabel.text = String(format: "$%.2f", tip)
        
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        billAmountTextField.keyboardType = .decimalPad
        billAmountTextField.becomeFirstResponder()
        
    }


}

