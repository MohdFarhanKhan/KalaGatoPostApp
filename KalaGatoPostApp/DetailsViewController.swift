//
//  DetailsViewController.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 18/02/1445 AH.
//

import UIKit
import FirebaseRemoteConfig
class DetailsViewController: UIViewController, UIAlertViewDelegate {
    @IBOutlet weak var tblPost: UITableView!
    private let postViewModel = PostViewModel()
    var postSelectedRecord : PostData? = nil
    var isPostFavorite = false
    var isRefretch = false
    private let remoteConfig = RemoteConfig.remoteConfig()
    var isNetConnected = false
    let child = SpinnerViewController()
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
                self.remoteConfig.activate { status,error in
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
        if NetworkReachability.shared.isConnected == true{
            isNetConnected = true
        }
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
        if isRefretch == true{
            fetchDataFromServer()
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
        
        let config = UIImage.SymbolConfiguration(scale: .large)
            var sfImageName = "star.fill"
        postViewModel.isFavoriteData(postId: (postSelectedRecord?.postData.id)!) { result in
            if result == true{
                sfImageName = "star.fill"
            }
            else{
                sfImageName = "star"
            }
        }
            let image = UIImage(systemName: sfImageName, withConfiguration: config)
           
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(favoriteTapped))
        
        DispatchQueue.main.async {
            if(self.postSelectedRecord != nil && self.postSelectedRecord?.comments?.count != 0){
               
                self.tblPost.reloadData()
            
              
            }
        }
       
    }
    @IBAction func favoriteTapped(_ sender: UIButton) {
        postViewModel.savrAsFavorite(postId: (postSelectedRecord?.postData.id)!) { [self] result in
            
            let alert = UIAlertController(title: "Favorite Status", message: result, preferredStyle: .alert)
                     
                  
                   alert.addAction(UIAlertAction(title: "OK",
                                                 style: UIAlertAction.Style.default,
                                                 handler: {(_: UIAlertAction!) in
                                                   
                   }))
                    
                   DispatchQueue.main.async {
                       self.present(alert, animated: false, completion: nil)
                   }
            let config = UIImage.SymbolConfiguration(scale: .large)
                var sfImageName = "star.fill"
            self.postViewModel.isFavoriteData(postId: (self.postSelectedRecord?.postData.id)!) { result in
                if result == true{
                    sfImageName = "star.fill"
                }
                else{
                    sfImageName = "star"
                }
            }
                let image = UIImage(systemName: sfImageName, withConfiguration: config)
               
                
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.favoriteTapped))
            if NetworkReachability.shared.isConnected == true && isNetConnected == false{
                fetchDataFromServer()
                isRefretch = false
            }
            else{
                isPostFavorite = true
                isRefretch = true
            }
            print(result)
        }
           
        }
    func showAlert(msg:String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let alert = UIAlertController(title: "Data fetching Status", message: msg, preferredStyle: .alert)
            
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: UIAlertAction.Style.default,
                                          handler: {(_: UIAlertAction!) in
                
            }))
            self.present(alert, animated: false, completion: nil)
        }
            
        
    }
    func fetchDataFromServer(){
        isRefretch = false
        DispatchQueue.main.async {
            self.addChild(self.child)
            self.child.view.frame = self.view.frame
            self.view.addSubview(self.child.view)
            self.child.didMove(toParent: self)
        }
       
        postViewModel.refetchData { status in
            
            DispatchQueue.main.async {
                self.child.willMove(toParent: nil)
                self.child.view.removeFromSuperview()
                self.child.removeFromParent()
             self.showAlert(msg: status)
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
