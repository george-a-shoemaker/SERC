//
//  PositionVC.swift
//  SERQ
//
//  Created by George Shoemaker on 5/1/23.
//

import UIKit

class PositionVC: UIViewController {
    
    private let viewModel = PositionVM()
    let nameLabel = UILabel()
    let numberLabel = UILabel()
    
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configureStackView()
        configureLabels()
    }
    
}

extension PositionVC {
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 16.0
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    func configureLabels() {
        
        let userString: String = {
            guard let user = viewModel.user else { return "[missing user ❌]"}
            return "\(user.lastName), \(user.firstNameInitial)"
        }()
        
        
        nameLabel.text = userString
        nameLabel.font = .systemFont(ofSize: 40, weight: .bold)
        nameLabel.textColor = RQColors.darkRed
        stackView.addArrangedSubview(nameLabel)
        
        let desriptorLabel0 = UILabel()
        desriptorLabel0.numberOfLines = 2
        desriptorLabel0.text = "holds position"
        desriptorLabel0.font = .systemFont(ofSize: 20)
        desriptorLabel0.textAlignment = .center
        stackView.addArrangedSubview(desriptorLabel0)
        
        Task {
            numberLabel.text = "\(await viewModel.userPosition)"
        }
        numberLabel.textColor = RQColors.darkRed
        stackView.addArrangedSubview(numberLabel)
        numberLabel.font = .systemFont(ofSize: 60, weight: .bold)
        stackView.addArrangedSubview(numberLabel)
    }
}
