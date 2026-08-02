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
    
    @Published private var query:String = ""
    private var filteredUsers = [User]()
    private var cancellables = Set<AnyCancellable>()
    var users = [User]()
    var usersVc: ViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.register(UINib(nibName: "TestCell", bundle: nil),
                                   forCellReuseIdentifier: "TestCell")
        
        filteredUsers = users
        $query
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map{ [users] text ->[User] in
                let q = text.trimmingCharacters(in: .whitespaces).lowercased()
                           guard !q.isEmpty else { return users }
                           return users.filter { $0.name.lowercased().contains(q)
                           }
            }
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] results in
                self?.filteredUsers = results
                self?.resultTableView.reloadData()
                
            }
            .store(in: &cancellables)
    }
    func searchWith(query: String) {
        
    }
    
    @IBAction func didTypeOnTextField(_ sender: Any) {
        query = searchTextField.text ?? ""
    }
    
  

}
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as! TestCell
        cell.titleLabel.text = filteredUsers[indexPath.row].name
        cell.subtitleLabel.text = filteredUsers[indexPath.row].createdAt
        cell.timeStampLabel.text = "10:00 AM"
        cell.readUnreadLabel.text = "Read"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = usersVc?.navigationController
        let user = filteredUsers[indexPath.row]
        dismiss(animated: true){
            let vc = AppConfig.storyBoard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
            vc.user = user
            nav?.pushViewController(vc, animated: true)
        }
        
    }
}
