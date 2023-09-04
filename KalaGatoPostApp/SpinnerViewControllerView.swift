//
//  SpinnerViewControllerView.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 19/02/1445 AH.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)

       override func loadView() {
           view = UIView()
          
           view.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.5)

           spinner.translatesAutoresizingMaskIntoConstraints = false
           spinner.startAnimating()
           view.addSubview(spinner)

           spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
