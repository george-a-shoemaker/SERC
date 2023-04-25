//
//  ViewController.swift
//  SERQ
//
//  Created by George Shoemaker on 4/19/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let refreshButton = UIButton()
    private let tableView = UITableView()
    
    private let loadingSpinner: UIView = UIView()
    
    private let dummyItems = Array(
        repeating: WaitlistItem(position: 99, lastName: "Jingleheimer", firstNameInitial: "J"),
        count: 120
    )
    
    private let waitListItems = [WaitlistItem]()
    
    private let cellReuseID = "waitlistItem"
    
    @objc func refreshButtonTapped(sender: UIButton) {
        print("tapped refresh button")
        viewModel.requestWaitlist()
    }
    
    private func showSpinner() {
        
        
    }
    
    private func hideSpinner() {
        loadingSpinner.isHidden = true
    }
    
    private func bindListeners() {
        viewModel.waitList.bind { [weak self] waitList in
            self?.tableView.reloadData()
            print("Waitlist received with \(waitList?.count ?? -1) items")
        }
        viewModel.isLoading.bind { [weak self] isLoading in
            print("isLoading = \(isLoading)")
            self?.loadingSpinner.isHidden = !isLoading
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        bindListeners()
        
        configureTitle()
        configureButton()
        configureTable()
        configureIsLoadingView()
        
        if viewModel.waitList.value == nil {
            viewModel.requestWaitlist()
        }
    }
}

extension ViewController {
    private func configureIsLoadingView() {
        loadingSpinner.frame = CGRect(
            x: view.frame.midX - 25, y: view.frame.midY - 25,
            width: 50, height: 50
        )
        loadingSpinner.backgroundColor = .purple
        loadingSpinner.alpha = 0.8
        loadingSpinner.layer.cornerRadius = 10
        
        let activityView = UIActivityIndicatorView(style: .medium)
        activityView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityView.color = .white
        activityView.startAnimating()
        
        loadingSpinner.addSubview(activityView)
        
        view.addSubview(loadingSpinner)
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
        refreshButton.addTarget(
            self,
            action: #selector(self.refreshButtonTapped),
            for: .touchUpInside
        )
        
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

extension ViewController {
    func addIsLoadingView() {
        
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dummyItems.count
        return viewModel.waitList.value?.count ?? 0
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseID
        )! as UITableViewCell
        
//        cell.textLabel?.text = waitListItems[indexPath.row].displayString
        cell.textLabel?.text = viewModel.waitList.value?[indexPath.row].displayString ?? ""
        
        cell.backgroundColor = {
            if (indexPath.row % 2 == 0) { return UIColor.white }
            return UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        }()
        
        return cell
    }
}

