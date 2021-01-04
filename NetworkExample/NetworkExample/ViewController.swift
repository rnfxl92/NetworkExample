//
//  ViewController.swift
//  NetworkExample
//
//  Created by 박성민 on 2021/01/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    private var handler: ((Result<[UserData], API.APIError>)->Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handler = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let userDatas):
                guard let userData = userDatas.first else { return }
                self.setInfo(by: userData)
            case .failure(let error):
                print("Error", error.localizedDescription)
                self.setError()
            }
        }
    }
    
    private func setInfo(by data: UserData) {
        DispatchQueue.main.async {
            self.resultLabel.text = """
                ID: \(data.id)\n
                Title: \(data.title)\n
                UserId: \(data.userId)\n
                Body: \(data.body)\n
                """
        }
    }
    
    private func setError() {
        DispatchQueue.main.async {
            self.resultLabel.text = """
                ID: Error\n
                Title: Error\n
                UserId: Error\n
                Body: Error\n
                """
        }
    }
}

extension ViewController {
    
    @IBAction private func created(_ sender: UIButton) {
        guard let url = URL(string: "https://github.com/rnfxl92/") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction private func GET1(_ sender: UIButton) {
        API.shared.get1(completionHandler: handler)
    }
    
    @IBAction private func GET2(_ sender: UIButton) {
        API.shared.get2(completionHandler: handler)
    }
    
    @IBAction private func POST(_ sender: UIButton) {
        API.shared.post(completionHandler: handler)
    }
    
    @IBAction private func PUT(_ sender: UIButton) {
        API.shared.put(completionHandler: handler)
    }
    
    @IBAction private func PATCH(_ sender: UIButton) {
        API.shared.patch(completionHandler: handler)
    }
    
    @IBAction private func DELETE(_ sender: UIButton) {
        API.shared.delete(completionHandler: handler)
    }
    
}

