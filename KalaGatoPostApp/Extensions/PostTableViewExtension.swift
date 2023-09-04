//
//  PostTableViewExtension.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 18/02/1445 AH.
//

import Foundation
import UIKit

extension PostViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        postRecords?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell") as! PostTableViewCell

        let postRecord = self.postRecords![indexPath.row].postData
        cell.lblId.text = "\(postRecord.id)"
        cell.lblUserId.text = "\(postRecord.userId)"
        cell.lblTitle.text = postRecord.title
        cell.lblBody.text = postRecord.body
      //  cell.lblAnimalName.text = postRecord.body

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        var viewController: DetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        viewController.postSelectedRecord = self.postRecords![indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
       
       
    }
}
