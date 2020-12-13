//
//  ViewController.swift
//  JunoExample
//
//  Created by Emre Onder on 13.12.2020.
//

import UIKit
import Juno

class ViewController: UIViewController {

    private let logButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Main Controller"
        view.backgroundColor = .white
        
        Juno.print("Console log Example")
        Juno.print("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
        
        logButton.setTitle("Print Current Date To Log", for: .normal)
        logButton.setTitleColor(UIColor.white, for: .normal)
        logButton.backgroundColor = UIColor(red: 52.0/255.0, green: 141.0/255.0, blue: 195.0/255.0, alpha: 1.0)
        logButton.layer.shadowColor = UIColor.black.cgColor
        logButton.layer.shadowRadius = 3
        logButton.layer.shadowOpacity = 0.8
        logButton.layer.shadowOffset = CGSize.zero
        logButton.layer.cornerRadius = 8.0
        logButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        logButton.translatesAutoresizingMaskIntoConstraints = false
        logButton.addTarget(self, action: #selector(addLogButtonTapped), for: .touchUpInside)
        view.addSubview(logButton)
        
        logButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc private func addLogButtonTapped() {
        Juno.print("Custom Log: \(Date())")
    }

}
