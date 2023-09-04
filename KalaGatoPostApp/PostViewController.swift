//
//  PostViewController.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 17/02/1445 AH.
//

import UIKit
import FirebaseRemoteConfig


class PostViewController: UIViewController, UIAlertViewDelegate {
    @IBOutlet weak var tblPost: UITableView!
    private let postViewModel = PostViewModel()
    var postRecords : Array<PostData>? = nil
    var isDataFetched = false
    let child = SpinnerViewController()
    private let remoteConfig = RemoteConfig.remoteConfig()
    func fetchValues(){
        let defaults:[String: NSObject] = [
            "shows_new_bgcolor": false as NSObject
        ]
        remoteConfig.setDefaults(defaults)
        
        let settings =  RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
      
       
        self.remoteConfig.fetch(withExpirationDuration: 0) { status, error in
            if status == .success, error == nil{
                self.remoteConfig.activate { status,error  in
                    guard error == nil else{
                        return
                    }
                    let value = self.remoteConfig.configValue(forKey: "shows_new_bgcolor").boolValue
                    DispatchQueue.main.async {
                        if value == false{
                            self.view.backgroundColor = .white
                            self.tblPost.backgroundColor = .white
                        }
                        else{
                            self.view.backgroundColor = .yellow
                            self.tblPost.backgroundColor = .yellow
                        }
                    }
                }
            }
            else{
                
            }
        }
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchValues()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(netConnected), name: Notification.Name("NetConnected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(netNotConnected), name: Notification.Name("NetNotConnected"), object: nil)
        // Do any additional setup after loading the view.
    }
    deinit{
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NetConnected"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NetNotConnected"), object: nil)
    }
    @objc func netConnected(){
        let alert = UIAlertController(title: "NetConnected?", message: "Internet is connected", preferredStyle: .alert)
                 
              
               alert.addAction(UIAlertAction(title: "OK",
                                             style: UIAlertAction.Style.default,
                                             handler: {(_: UIAlertAction!) in
                                               
               }))
                
               DispatchQueue.main.async {
                   self.present(alert, animated: false, completion: nil)
               }
        if isDataFetched == false{
            getData()
        }
       
    }
    @objc func netNotConnected(){
        let alert = UIAlertController(title: "NetNotConnected?", message: "Internet is disconnected", preferredStyle: .alert)
                 
              
               alert.addAction(UIAlertAction(title: "OK",
                                             style: UIAlertAction.Style.default,
                                             handler: {(_: UIAlertAction!) in
                                               
               }))
                
               DispatchQueue.main.async {
                   self.present(alert, animated: false, completion: nil)
               }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
       getData()
    }
    func getData(){
        if  NetworkReachability.shared.isConnected == true{
                    // add the spinner view controller
                    addChild(child)
                    child.view.frame = view.frame
                    view.addSubview(child.view)
                    child.didMove(toParent: self)

           
            postViewModel.getData {[weak self] posts in
                DispatchQueue.main.async { [self] in
                    if(posts != nil && posts?.count != 0){
                        self?.postRecords = posts!
                        self?.tblPost.reloadData()
                    
                        do{
                            try PersistentStorage.shared.saveContext()
                        }
                        catch{
                            print("error in saving")
                        }
                        self?.isDataFetched = true
                    }
                    else{
                        self?.isDataFetched = false
                    }
                    self?.child.willMove(toParent: nil)
                    self?.child.view.removeFromSuperview()
                    self?.child.removeFromParent()
                }
            }
         }
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
