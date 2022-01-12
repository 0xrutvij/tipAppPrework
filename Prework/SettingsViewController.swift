//
//  SettingsViewController.swift
//  Prework
//
//  Created by Rutvij Shah on 1/10/22.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

	@IBOutlet weak var tip1TextField: UITextField!
	@IBOutlet weak var tip2TextField: UITextField!
	@IBOutlet weak var tip3TextField: UITextField!
	@IBOutlet weak var currencyPicker: UIPickerView!
	@IBOutlet weak var darkModeSwitch: UISwitch!

	var pickerStateInfo: [(currency: String, symbol: String)] = []
	var selectedCurrency: (currency: String, symbol: String) = ("USD", "$")

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerStateInfo.count
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return pickerStateInfo[row].currency + " " + pickerStateInfo[row].symbol
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedCurrency = pickerStateInfo[row]
		return
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if pickerStateInfo.isEmpty {
			loadCurrencyData()
		}

		let defaults = UserDefaults.standard

		tip1TextField.text = defaults.string(forKey: "tip1Default") ?? ""

		tip2TextField.text = defaults.string(forKey: "tip2Default") ?? ""

		tip3TextField.text = defaults.string(forKey: "tip3Default") ?? ""

		let currency = defaults.string(forKey: "currency") ?? "USD"

		let symbol = defaults.string(forKey: "symbol") ?? "$"

		selectedCurrency = (currency, symbol)

		if defaults.bool(forKey: "darkMode") {
			overrideUserInterfaceStyle = .dark
			darkModeSwitch.setOn(true, animated: true)
		} else {
			overrideUserInterfaceStyle = .light
			darkModeSwitch.setOn(false, animated: true)
		}

		tip1TextField.becomeFirstResponder()
	}

	override func viewDidLoad() {
        super.viewDidLoad()
		currencyPicker.delegate = self
		currencyPicker.dataSource = self
        // Do any additional setup after loading the view.
    }

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		let defaults = UserDefaults.standard

		defaults.set(selectedCurrency.currency, forKey: "currency")

		defaults.set(selectedCurrency.symbol, forKey: "symbol")

		if let text1 = tip1TextField.text {
			defaults.set(text1, forKey: "tip1Default")
		}

		if let text2 = tip2TextField.text {
			defaults.set(text2, forKey: "tip2Default")
		}

		if let text3 = tip3TextField.text {
			defaults.set(text3, forKey: "tip3Default")
		}

		if darkModeSwitch.isOn {
			defaults.set(true, forKey: "darkMode")
		} else {
			defaults.set(false, forKey: "darkMode")
		}

		defaults.synchronize()

	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		let sym = selectedCurrency.currency

		for (idx, comp) in pickerStateInfo.enumerated() where comp.currency == sym {
				currencyPicker.selectRow(idx, inComponent: 0, animated: true)
		}
	}

	@IBAction func darkModeFlicked(_ sender: Any) {
		if darkModeSwitch.isOn {
			overrideUserInterfaceStyle = .dark
		} else {
			overrideUserInterfaceStyle = .light
		}
	}

	private func loadCurrencyData() {
		pickerStateInfo = []

		guard let filePath = Bundle.main.path(forResource: "currency", ofType: "json") else {
			return
		}

		guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
			return
		}

		guard let rawCurrencyData = try? JSONDecoder().decode([String: CurrencyInfo].self, from: jsonData) else {
			return
		}

		for (key, value) in rawCurrencyData {
			// swiftlint:disable all
			pickerStateInfo.append((currency: key, symbol: value.symbol_native))
			// swiftlint:enable all
		}

		pickerStateInfo.sort(by: {$0.currency < $1.currency })

		return

	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
