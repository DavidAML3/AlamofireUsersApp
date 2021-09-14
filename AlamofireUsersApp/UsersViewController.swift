//
//  ViewController.swift
//  AlamofireUsersApp
//
//  Created by David Andres Mejia Lopez on 13/09/21.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        let service = Service(baseUrl: "https://jsonplaceholder.typicode.com/")
        service.getAllUsersNameFrom(endPoint: "users")
        service.completionHandler { [weak self] (users, status, message) in
            if status {
                guard let self = self else { return }
                guard let users = users else { return }
                self.users = users
                self.tableView.reloadData()
            }
        }
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UserCell")
        }
        
        let user = users[indexPath.row]
        cell?.textLabel?.text = user.name
        cell?.detailTextLabel?.text = "Email: " + user.email + " Username: " + user.username
        return cell!
    }
}
