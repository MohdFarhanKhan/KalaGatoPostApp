//
//  DetailsTableiwExtension.swift
//  KalaGatoPostApp
//
//  Created by Najran Emarah on 18/02/1445 AH.
//

import Foundation
import UIKit

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        postSelectedRecord?.comments?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell") as! DetailsTableViewCell

        let postRecord = self.postSelectedRecord?.comments![indexPath.row]
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
