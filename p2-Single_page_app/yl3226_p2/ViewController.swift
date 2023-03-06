//
//  ViewController.swift
//  yl3226_p2
//
//  Created by Andrew Liu on 3/5/23.
//

import UIKit

class ViewController: UIViewController {
    var titleLabel = UILabel()
    var profileImageView = UIImageView()
    
    var inputWarningTextView = UITextField()
    
    var inputStackView = UIStackView()
    var ingredientTextField = UITextField()
    var quantityTextField = UITextField()
    
    var recipeTextView = UITextView()
    
    var addButton = UIButton()
    
    var ingredientList: [String] = []
    var quantityList: [String] = []
    
    let addSwitch = UISwitch()
    let editModeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSwitch.setOn(false, animated: true)
        addSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        addSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addSwitch)
        
        editModeLabel.text = "Edit"
        editModeLabel.font = UIFont(name: "Georgia", size: 15)
        editModeLabel.textColor = .black
        editModeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editModeLabel)
        
        if let coffeeImage = UIImage(named: "coffee2") {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 150, height: 150))
            let resizedImage = renderer.image { _ in
                coffeeImage.draw(in: CGRect(x: 0, y: 0, width: 150, height: 150))
            }
            profileImageView.image = resizedImage
        }
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFit
        view.addSubview(profileImageView)
        
        titleLabel.text = "Coffee Recipe"
        titleLabel.font = UIFont(name: "Georgia-Italic", size: 30)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        inputWarningTextView.isUserInteractionEnabled = false
        inputWarningTextView.translatesAutoresizingMaskIntoConstraints = false
        inputWarningTextView.font = UIFont(name: "Georgia", size: 15)
        inputWarningTextView.textColor = .red
        view.addSubview(inputWarningTextView)
        
        ingredientTextField.placeholder = "Ingredient"
        ingredientTextField.borderStyle = .roundedRect
        ingredientTextField.font = UIFont(name: "Georgia", size: 15)
        ingredientTextField.translatesAutoresizingMaskIntoConstraints = false
        
        quantityTextField.placeholder = "Quantity"
        quantityTextField.borderStyle = .roundedRect
        quantityTextField.font = UIFont(name: "Georgia", size: 15)
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false

        inputStackView = UIStackView(arrangedSubviews: [ingredientTextField, quantityTextField])
        inputStackView.backgroundColor = .systemGray5
        inputStackView.axis = .vertical
        inputStackView.isLayoutMarginsRelativeArrangement = true
        inputStackView.spacing = 5
        inputStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10)
        inputStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputStackView)
        
        recipeTextView.isEditable = false
        recipeTextView.translatesAutoresizingMaskIntoConstraints = false
        recipeTextView.backgroundColor = .clear
        recipeTextView.font = UIFont(name: "Georgia", size: 15)
        view.addSubview(recipeTextView)
        
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.titleLabel?.font = UIFont(name: "Georgia-bold", size: 15)
        addButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)

        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            inputWarningTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputWarningTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputWarningTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            inputStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputStackView.topAnchor.constraint(equalTo: inputWarningTextView.bottomAnchor, constant: 15)
        ])
                
        NSLayoutConstraint.activate([
            recipeTextView.topAnchor.constraint(equalTo: quantityTextField.bottomAnchor, constant: 20),
            recipeTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recipeTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            recipeTextView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -20)
        ])
        
        
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            addSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            editModeLabel.trailingAnchor.constraint(equalTo: addSwitch.leadingAnchor, constant: -10),
            editModeLabel.centerYAnchor.constraint(equalTo: addSwitch.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            addSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func buttonAction() {
        var validInputs = true
        inputWarningTextView.isHidden = !validInputs
        if(addButton.isSelected) {
            if let ingredient = ingredientTextField.text, let quantity = quantityTextField.text {
                if(ingredient.isEmpty && quantity.isEmpty) {
                    validInputs = false
                    inputWarningTextView.text = "Please enter an ingredient and the correct quantity."
                } else if(ingredient.isEmpty) {
                    validInputs = false
                    inputWarningTextView.text = "Please enter an ingredient."
                } else if(quantity.isEmpty) {
                    validInputs = false
                    inputWarningTextView.text = "Please enter the correct quantity"
                } else {
                    ingredientList.append(ingredient)
                    quantityList.append(quantity)
                    validInputs = true
                }
            }
            
            if validInputs {
                var itemListText = ""
                for (index, ingredient) in ingredientList.enumerated() {
                    itemListText += "\(quantityList[index]) "
                    itemListText += ingredient
                    itemListText += "\n"
                }
                
                recipeTextView.text = itemListText
                inputWarningTextView.text = ""
            }
        }
        
        addButton.isSelected.toggle();
    }
    
    @objc func switchAction(sender:UISwitch) {
        addButton.isEnabled = sender.isOn
        
        if(addButton.isEnabled == false) {
            inputWarningTextView.isHidden = true
        }
    }
    
}

