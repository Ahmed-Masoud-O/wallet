//
//  ViewController.swift
//  wallet
//
//  Created by Ahmed masoud on 3/31/17.
//  Copyright © 2017 Ahmed masoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum localKeys: String {
        case wallet = "wallet"
        case budget = "budget"
    }
    let localStorage = UserDefaults.standard
    var analysisArray = [[String:Double]]()
    @IBOutlet weak var categoryLbl: UITextField!
    @IBOutlet weak var mainBudgetLbl: UILabel!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var cashInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        addDoneToKeyboard(textField: [cashInput,categoryLbl], doneButton: doneButton)
        if let tempArray: [[String: Double]] = localStorage.array(forKey: "array") as? [[String : Double]]{
            analysisArray = tempArray
        }
        
        if let currentBudget = localStorage.string(forKey: localKeys.budget.rawValue) {
            mainBudgetLbl.text = String(currentBudget)
        }
        if let currentWallet = localStorage.string(forKey: localKeys.wallet.rawValue) {
            walletLbl.text = String(currentWallet)
        }
        
    }

    @IBAction func updateBudget(_ sender: Any) {
        let userInputCash = Double(cashInput.text!)!
        let oldBudget = Double(mainBudgetLbl.text!)!
        let newBudget = userInputCash + oldBudget
        localStorage.set(newBudget, forKey: localKeys.budget.rawValue)
        mainBudgetLbl.text = String(newBudget)
        analysisArray.append(["updated Budget By":userInputCash])
        localStorage.set(analysisArray, forKey: "array")
        clearInputFields()
    }
    @IBAction func addToWallet(_ sender: Any) {
        let userInputCash = Double(cashInput.text!)!
        let oldWallet = Double(walletLbl.text!)!
        let newWallet = userInputCash + oldWallet
        localStorage.set(newWallet, forKey: localKeys.wallet.rawValue)
        walletLbl.text = String(newWallet)
        let oldBudget = Double(mainBudgetLbl.text!)!
        let newBudget = oldBudget - userInputCash
        localStorage.set(newBudget, forKey: localKeys.budget.rawValue)
        mainBudgetLbl.text = String(newBudget)
        analysisArray.append(["Added To Wallet":userInputCash])
        localStorage.set(analysisArray, forKey: "array")
        clearInputFields()
    }
    @IBAction func payFromWallet(_ sender: Any) {
        let userInputCash = Double(cashInput.text!)!
        let oldWallet = Double(walletLbl.text!)!
        let newWallet = oldWallet - userInputCash
        localStorage.set(newWallet, forKey: localKeys.wallet.rawValue)
        walletLbl.text = String(newWallet)
        let category = categoryLbl.text!
        analysisArray.append([category:userInputCash])
        localStorage.set(analysisArray, forKey: "array")
        clearInputFields()
    }
    @IBAction func viewAnalysis(_ sender: Any) {
        let view = AnalysisTable()
        //present(view, animated: true, completion: nil)
        self.navigationController?.pushViewController(view, animated: true)
    }
    @IBAction func flusBudget(_ sender: Any) {
        localStorage.set("0.0", forKey: localKeys.budget.rawValue)
        mainBudgetLbl.text = "0.0"
        
        
    }
    @IBAction func flushWallet(_ sender: Any) {
        localStorage.set("0.0", forKey: localKeys.wallet.rawValue)
        walletLbl.text = "0.0"
        
    }
    
    @IBAction func flushAnalysis(_ sender: Any) {
        analysisArray.removeAll()
        localStorage.set(analysisArray, forKey: "array")
    }
    func clearInputFields(){
        cashInput.text = ""
        categoryLbl.text = ""
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func addDoneToKeyboard(textField : [UITextField],doneButton : UIBarButtonItem!){
        
        /* customize the keyboards just add done accessory */
        let toolBar = UIToolbar()
        
        /* to fix tool bar not appearing */
        toolBar.sizeToFit()
        
        /*flexible space to push done button to the right */
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        /* add items too toolbar */
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        
        /* add tool bar */
        for field in textField{
            field.inputAccessoryView = toolBar
        }
        
    }
    func doneClicked(){
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

