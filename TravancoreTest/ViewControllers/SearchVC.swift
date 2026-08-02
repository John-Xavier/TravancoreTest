//
//  SearchVC.swift
//  TravancoreTest
//
//  Created by John Xavier  on 02/08/2026.
//

import UIKit
import Combine

class SearchVC: UIViewController {

    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultTableView: UITableView!
    
    var users = [User]()
    var usersVc: ViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.register(UINib(nibName: "TestCell", bundle: nil),
                                   forCellReuseIdentifier: "TestCell")
    }
    func searchWith(query: String) {
//        query.debounce(for: 0.5, scheduler: DispatchQueue.main, options: .none)
//            .removeDuplicates()
//            .filter { !$0.isEmpty }
    }
    
    @IBAction func didTypeOnTextField(_ sender: Any) {
        
    }
    
  

}
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as! TestCell
        cell.titleLabel.text = users[indexPath.row].name
        cell.subtitleLabel.text = users[indexPath.row].createdAt
        cell.timeStampLabel.text = "10:00 AM"
        cell.readUnreadLabel.text = "Read"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AppConfig.storyBoard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        usersVc?.navigationController?.pushViewController(vc, animated: true)
        
    }
}
