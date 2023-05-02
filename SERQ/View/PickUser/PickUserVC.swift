//
//  PickUserVC.swift
//  SERQ
//
//  Created by George Shoemaker on 4/19/23.
//

import UIKit

class PickUserVC: UIViewController {
    
    private let viewModel = PickUserVM()
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let refreshButton = UIButton()
    private let tableView = UITableView()
    
    private let loadingSpinner: UIView = UIView()
    
    private let waitListItems = [WaitListItem]()
    
    private let cellReuseID = "waitlistItem"
    
    @objc func refreshButtonTapped(sender: UIButton) {
        print("tapped refresh button")
        viewModel.refreshWaitlist()
    }
    
    private func bindListeners() {
        viewModel.userNameList.bind { [weak self] waitList in
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
        
        if viewModel.userNameList.value == nil {
            viewModel.requestWaitlist()
        }
    }
}

extension PickUserVC {
    private func configureIsLoadingView() {
        loadingSpinner.frame = CGRect(
            x: view.frame.midX - 25, y: view.frame.midY - 25,
            width: 50, height: 50
        )
        loadingSpinner.backgroundColor = .gray
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
        

        subtitleLabel.text = "Pick your name!"
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
        refreshButton.backgroundColor = RQColors.darkRed
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

extension PickUserVC {
    func addIsLoadingView() {
        
        
    }
}

extension PickUserVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userNameList.value?.count ?? 0
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseID
        )! as UITableViewCell
        
        
        cell.textLabel?.text =  {
            guard let userName = viewModel.userNameList.value?[indexPath.row] else {
                return ""
            }
            return "\(userName.lastName), \(userName.firstNameInitial)."
        }()
        
        cell.backgroundColor = {
            if (indexPath.row % 2 == 0) { return UIColor.white }
            return UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        }()
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.userSelected(at: indexPath.row)
        navigationController?.pushViewController(PositionVC(nibName: nil, bundle: nil), animated: true)
    }
}

