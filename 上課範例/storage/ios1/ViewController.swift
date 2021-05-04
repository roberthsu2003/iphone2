//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/29.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    let firestore = Firestore.firestore()
    //closure的執行,只會執行一次
    lazy var cities:[[String:String]] = {
        let pathURL = Bundle.main.url(forResource: "citylist", withExtension: "plist")!
        let cities = NSArray(contentsOf: pathURL) as! [[String:String]]
        return cities
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //登入動作
        if Auth.auth().currentUser == nil{
            print("nil")
            performSegue(withIdentifier: "goLoading", sender: nil)
        }else{
            print("login完成")
            //performSegue(withIdentifier: "goLoading", sender: nil)
        }
        
        //檢查Firestore有沒有資料
        firestore.collection("cities").getDocuments { (snapshot:QuerySnapshot?, error:Error?) in
            guard let snapshot = snapshot, error == nil else{
                print("取得documents失敗")
                return
            }
            
            if snapshot.isEmpty{
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "匯入資料", style: .plain, target: self, action: #selector(self.uploadStoreData(_:)))
            }else{
                print("已經有資料")
            }
        }
        
        
    }
    
    

    @objc func uploadStoreData(_ sender:UIBarButtonItem){
        let batch = firestore.batch()
        for city in cities{
            let documentRef = firestore.collection("cities").document()
            batch.setData(city, forDocument: documentRef)
        }
        
        batch.commit { (error:Error?) in
            if error == nil{
                print("批次上傳Firestore成功")
                self.uploadImage()
            }else{
                print("批次上傳Firestore失敗")
            }
        }
        
        
    }
    
    func uploadImage(){
        
    }
}

