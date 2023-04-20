//
//  ViewController.swift
//  SERQ
//
//  Created by George Shoemaker on 4/19/23.
//

import UIKit

class ViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    let refreshButton = UIButton()
    private var tableView = UITableView()
    
    let dummyItems = Array(
        repeating: WaitlistItem(position: 99, lastName: "Jingleheimer", firstNameInitial: "J"),
        count: 120
    )
    let cellReuseID = "waitlistItem"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configureTitle()
        configureButton()
        configureTable()

    }
    
    private func configureTable() {
//        tableView.frame = CGRect(
//            x: 0, y: 50,
//            width: UIScreen.main.bounds.size.width,
//            height: UIScreen.main.bounds.size.height
//        )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 12),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: refreshButton.topAnchor, constant: -12)
        ])
    }
    
    private func configureTitle() {
        titleLabel.text = "SERQ"
        titleLabel.font = .systemFont(ofSize: 40, weight: .heavy)
        titleLabel.textColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        ])
        

        subtitleLabel.text = "( South End Rowing Queue )"
        subtitleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        subtitleLabel.textColor = .black

        view.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
        ])
    }
    
    private func configureButton() {
        refreshButton.setTitle("Refresh", for: .normal)
        refreshButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        refreshButton.backgroundColor = .purple
        refreshButton.setTitleColor(.white, for: .normal)
        refreshButton.layer.cornerRadius = 8
        
        addButtonConstraints()
    }
    
    private func addButtonConstraints() {
        view.addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            refreshButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            refreshButton.widthAnchor.constraint(equalToConstant: 260),
            refreshButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyItems.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseID
        )! as UITableViewCell
        
        cell.textLabel?.text = dummyItems[indexPath.row].displayString
        
        cell.backgroundColor = {
            if (indexPath.row % 2 == 0) { return UIColor.white }
            return UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        }()
        
        return cell
    }
}

