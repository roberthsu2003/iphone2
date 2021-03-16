//
//  ViewController.swift
//  lesson1_1
//
//  Created by 徐國堂 on 2021/3/16.
//

import UIKit

class ViewController: UITableViewController {
    var states:[String:[String]]!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let targetPath = Bundle.main.path(forResource: "statedictionary", ofType: "plist"){
            
            if let states = NSDictionary(contentsOfFile: targetPath) as? [String:[String]]{
                self.states = states
            }
            
        }
        
        
        //tableView.dataSource = self;
        
    }


}

extension ViewController{
    //UITableViewDataSource
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int{
        
    }
    
    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
    }
}

