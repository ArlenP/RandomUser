//
//  ViewControllerSettings.swift
//  RandomUser
//
//  Created by Arlen Peña on 01/08/23.
//

import UIKit

class ViewControllerSettings: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setupBackground()
    }
    
    func setupBackground(){
        self.view.backgroundColor = AppColors.pink
    }
}

extension ViewControllerSettings: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuApp.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text = MenuApp.settings[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Settings Menu"
    }
    
}
