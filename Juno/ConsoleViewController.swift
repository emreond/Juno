//
//  ConsoleViewController.swift
//  Juno
//
//  Created by Emre Onder on 13.12.2020.
//

import Foundation
import UIKit

class ConsoleViewController: UIViewController {
    
    // MARK: - Views
    private let tableView = UITableView()
    
    // MARK: - Properties
    private var dataSource = Logger.instance.logs
    private let reuseIdentifier = "consoleCellReuseIdentifier"
    var onClose: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onClose?()
    }
    
    private func setupViews() {
        title = "Console Log"
        
        view.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.allowsSelection = false
        tableView.separatorColor = .lightGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        let closeBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .done,
            target: self,
            action: #selector(closeButtonTapped))
        
        let clearAllBarButtonItem = UIBarButtonItem(
            title: "Clear All Logs",
            style: .done,
            target: self,
            action: #selector(clearAllButtonTapped))
        
        navigationItem.leftBarButtonItem = closeBarButtonItem
        navigationItem.rightBarButtonItem = clearAllBarButtonItem
        
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func clearAllButtonTapped() {
        Logger.instance.clearLogs(completion: { [weak self] in
            self?.dataSource = Logger.instance.logs
            self?.tableView.reloadData()
        })
    }
}

extension ConsoleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        let log = dataSource[indexPath.row]
        tableViewCell?.backgroundColor = .black
        tableViewCell?.textLabel?.textColor = .white
        tableViewCell?.textLabel?.text = log
        tableViewCell?.textLabel?.numberOfLines = 0
        return tableViewCell ?? .init()
    }
}
