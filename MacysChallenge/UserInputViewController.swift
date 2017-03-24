//
//  UserInputViewController.swift
//  MacysChallenge
//
//  Created by parry on 3/22/17.
//  Copyright © 2017 parry. All rights reserved.
//

import UIKit

final class UserInputViewController: UIViewController {

    fileprivate var inputTextField: UITextField
    fileprivate var titleLabel: UILabel
    fileprivate var submitButton: UIButton
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    init?(_ coder: NSCoder? = nil) {
        self.inputTextField = UITextField()
        self.titleLabel = UILabel()
        self.submitButton = UIButton()
        
        if let coder = coder {
            super.init(coder: coder)
        }
        else {
            super.init(nibName: nil, bundle:nil)
        }
    }
    

    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(netHex: 0x1695A3)
        
        titleLabel.text = "Meanings"
        titleLabel.font = UIFont(name: "Avenir-Book", size: 36)
        titleLabel.textColor = UIColor.white
        
        inputTextField.font = UIFont(name: "Avenir-Book", size: 16)
        inputTextField.textColor = UIColor.white
        inputTextField.attributedPlaceholder = NSAttributedString(string:"Type here to enter an acronym or initialism", attributes: [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName :UIFont(name: "Avenir-Book", size: 16)!])
        inputTextField.textAlignment = .center
        inputTextField.delegate = self
        
        submitButton.setTitle("Submit", for: UIControlState())
        submitButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 20)
        submitButton.layer.borderWidth = 0.0
        submitButton.titleLabel?.textColor = UIColor.white
        
        submitButton.isHidden = true
        submitButton.addTarget(self, action: #selector(onSubmitButtonPressed), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UserInputViewController.presentBadRequestAlert), name: NSNotification.Name(rawValue: "invalidInput"), object: nil)

        
        setConstraints()
    }
    
    
    override func loadView() {
        self.view = UIView()
        self.view.addSubview(inputTextField)
        self.view.addSubview(titleLabel)
        self.view.addSubview(submitButton)
    }

    
    func onSubmitButtonPressed(_ sender: UIButton) {
        
        if let inputText = inputTextField.text {
            Meaning.retrieveMeanings(inputText.removeWhitespace()) { (data, error) in
                
                let x = data
                print(x)
                
//                if let weatherVC = WMWeatherCollectionViewController(forecasts: data) {
//                    DispatchQueue.main.async(execute: {
//                        self.present(weatherVC, animated: true, completion: nil)
//                    })
//                }
            }
        }
    }
    
    
    func presentBadRequestAlert() {
        let alertController = UIAlertController(title: nil, message: "oops looks like that acronym or initialism is not supported", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
        }))
        
        present(alertController, animated: true, completion: nil)
    }


    //MARK: AutoLayout

    func setConstraints() {
        
        let margins = view.layoutMarginsGuide
        
        view.translatesAutoresizingMaskIntoConstraints = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 100).isActive = true
        
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100).isActive = true
        inputTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.topAnchor.constraint(equalTo: inputTextField.layoutMarginsGuide.bottomAnchor, constant: 50).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}



extension UserInputViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.characters.count)! > 0 {
            submitButton.isHidden = false
            
        }
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
    
