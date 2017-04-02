//
//  AnalysisTable.swift
//  wallet
//
//  Created by Ahmed masoud on 4/1/17.
//  Copyright © 2017 Ahmed masoud. All rights reserved.
//

import Foundation
import UIKit

class AnalysisTable: UITableViewController {
    let localStorage = UserDefaults.standard
    var analysisArray: [[String: Double]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        analysisArray = (localStorage.array(forKey: "array") as? [[String : Double]])!
        analysisArray.reverse()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backFunction))
        navigationItem.title = "Analysis"
        tableView.reloadData()
    }
    
    func backFunction(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return analysisArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = Array(analysisArray[indexPath.row].keys)[0]
        cell.detailTextLabel?.text = String(Array(analysisArray[indexPath.row].values)[0])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
}
