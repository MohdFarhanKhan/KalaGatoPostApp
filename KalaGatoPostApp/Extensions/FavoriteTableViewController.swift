//
//  FavoriteTableViewController.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 18/02/1445 AH.
//

import Foundation
import UIKit

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        favoriteRecords?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        favoriteRecords?[section].comments?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view =  UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        view.backgroundColor = .init(red: 1.0, green: 0, blue: 0, alpha: 0.5)
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        lblTitle.text = favoriteRecords?[section].postData.title
        lblTitle.numberOfLines = 3
        lblTitle.textAlignment = .center
        view.addSubview(lblTitle)
        return view
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell") as! FavoriteTableViewCell

        let postRecord =  favoriteRecords?[indexPath.section].comments?[indexPath.row]
        cell.lblId.text = "\(postRecord!.id)"
        cell.lblPostId.text = "\(postRecord!.postID)"
        cell.lblName.text = postRecord!.name
        cell.lblBody.text = postRecord!.body
        cell.lblEmail.text = postRecord!.email
        cell.lblBody.text = postRecord!.body
     

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
      
       
    }
}
