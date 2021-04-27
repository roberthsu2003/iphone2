//
//  EditViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/22.
//

import UIKit
import Firebase

class EditViewController: UITableViewController {
    var queryDocumentSnapshot:QueryDocumentSnapshot!
    @IBOutlet var nameField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = queryDocumentSnapshot.get("name") as! String
        nameField.text = name
       
    }
    
    @IBAction func userPressDone(_ sender:UIBarButtonItem){
        print("更新本地端資料，更新雲端資料，回ViewController")
    }

    
}
