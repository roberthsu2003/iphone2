//
//  ViewController.swift
//  ios1
//
//  Created by 徐國堂 on 2021/4/15.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var firestore = Firestore.firestore()
    var queryDocuments:[QueryDocumentSnapshot]!
    lazy var presidents:[[String:String]] = {
        let pathURL = Bundle.main.url(forResource: "PresidentList", withExtension: "plist")
        guard let rootDictionary = NSDictionary(contentsOf: pathURL!) as? [String:Any] else{
            return [[:]]
        }
        let presidents = rootDictionary["presidents"]
        return presidents as! [[String:String]]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil{
            print("登入完成")
            doAnotherThing()
        }else{
            Auth.auth().signInAnonymously { (result:AuthDataResult?, error:Error?) in
                guard let _ = result, error == nil else{
                    print("登入錯誤")
                    return
                }
                self.doAnotherThing()
            }
        }
    }

    func doAnotherThing(){
        /* 取得特定文件名稱的資料
        let docRef = firestore.collection("presidents").document("5Eg79ELFLfX4AYCNdyXJ")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print(document.get("name") as! String)
                print(document.get("url") as! String)
                print("有資料")
            } else {
                print("沒有資料")
            }
        }
 */
        
        //取得所有collection的documents
        firestore.collection("presidents").getDocuments { (snapshot:QuerySnapshot?, error:Error?) in
            guard let snapshot = snapshot, error == nil else{
                print("取得所有documents失敗")
               return
            }
            if snapshot.isEmpty {
                print("沒有資料")
            }else{
                self.queryDocuments = snapshot.documents
                
                /*
                for queryDocument in self.queryDocuments{
                    print(queryDocument.data())
                }
                 */
            }
            
            
        }

        
    }
    
    @IBAction func uploadData(_ sender:UIBarButtonItem){
        let batch = firestore.batch()
        for president in presidents{
            let documentRef = firestore.collection("presidents").document()
            batch.setData(president, forDocument: documentRef)
        }
        
        batch.commit { (error:Error?) in
            if error == nil{
                print("batch成功")
            }else{
                print("batch失敗")
            }
        }
    }
}

