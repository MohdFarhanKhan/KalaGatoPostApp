//
//  FavoriteViewController.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 17/02/1445 AH.
//

import UIKit
import FirebaseRemoteConfig
class FavoriteViewController: UIViewController, UIAlertViewDelegate {
    @IBOutlet weak var tblPost: UITableView!
    private let postViewModel = PostViewModel()
    var favoriteRecords : Array<PostData>? = nil
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
                self.remoteConfig.activate { status, error in
                    guard error == nil else{
                        return
                    }
                    let value = self.remoteConfig.configValue(forKey: "shows_new_bgcolor").boolValue
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
       
        postViewModel.getFavoriteData { result in
            self.favoriteRecords = result
            self.tblPost.reloadData()
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
