//
//  ViewController.swift
//  Prework
//
//  Created by Rutvij Shah on 1/8/22.
//

import UIKit

class TipsterViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipPercentLabel: UILabel!

    var tipPercentages = [15, 18, 20]
    var currencySymbol = "$"

    @IBAction func otherTipPercent(_ sender: Any) {

        let tipPercentIdx = tipControl.selectedSegmentIndex

        if tipPercentIdx == 3 {
            tipSlider.isEnabled = true
        } else {
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

        tipAmountLabel.text = String(format: "\(currencySymbol)%.2f", tip)

        totalLabel.text = String(format: "\(currencySymbol)%.2f", total)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
        billAmountTextField.keyboardType = .decimalPad
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        var title: String

        if let tip1 = defaults.string(forKey: "tip1Default") {
            tipPercentages[0] = Int(tip1) ?? 15
            title = String(tipPercentages[0])
            tipControl.setTitle(title, forSegmentAt: 0)
        }

        if let tip2 = defaults.string(forKey: "tip2Default") {
            tipPercentages[1] = Int(tip2) ?? 18
            title = String(tipPercentages[1])
            tipControl.setTitle(title, forSegmentAt: 1)
        }

        if let tip3 = defaults.string(forKey: "tip3Default") {
            tipPercentages[2] = Int(tip3) ?? 20
            title = String(tipPercentages[2])
            tipControl.setTitle(title, forSegmentAt: 2)
        }

        if let sym = defaults.string(forKey: "symbol") {
            currencySymbol = sym
        } else {
            currencySymbol = "$"
        }

        if let billAmt = defaults.string(forKey: "billAmt") {
            billAmountTextField.text = billAmt
        }

        if defaults.bool(forKey: "darkMode") {
            overrideUserInterfaceStyle = .dark
        } else {
            overrideUserInterfaceStyle = .light
        }

        otherTipPercent(self)
        billAmountTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("View will disappear")

        let defaults = UserDefaults.standard

        defaults.set(billAmountTextField.text, forKey: "billAmt")
        defaults.synchronize()

    }

}
