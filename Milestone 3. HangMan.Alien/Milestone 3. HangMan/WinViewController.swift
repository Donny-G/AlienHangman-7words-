//
//  WinViewController.swift
//  Milestone 3. HangMan
//
//  Created by Donny G on 09/05/2019.
//  Copyright © 2019 Donny G. All rights reserved.
//

import UIKit

class WinViewController: UIViewController {
    var mainViewController: ViewController?
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .black
        
        let winImage = UIImageView()
        winImage.translatesAutoresizingMaskIntoConstraints = false
        winImage.image = UIImage(named: "win.jpg")
        view.addSubview(winImage)
        
        let youWinImage = UIImageView()
        youWinImage.translatesAutoresizingMaskIntoConstraints = false
        youWinImage.image = UIImage(named: "youwin.png")
        view.addSubview(youWinImage)
        
        let newGameButton = UIButton(type: .system)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.addTarget(self, action: #selector(newGame), for: .touchUpInside)
        view.addSubview(newGameButton)
        newGameButton.setBackgroundImage(UIImage(named: "newgamebutton.jpg"), for: .normal)
        
        NSLayoutConstraint.activate([
            winImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            winImage.widthAnchor.constraint(equalToConstant: 400),
            winImage.heightAnchor.constraint(equalToConstant: 400),
            
            youWinImage.topAnchor.constraint(equalTo: winImage.bottomAnchor),
            youWinImage.widthAnchor.constraint(equalToConstant: 100),
            youWinImage.heightAnchor.constraint(equalToConstant: 100),
            youWinImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            youWinImage.bottomAnchor.constraint(equalTo: newGameButton.topAnchor),
            
            newGameButton.topAnchor.constraint(equalTo: youWinImage.bottomAnchor),
            newGameButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButton.widthAnchor.constraint(equalToConstant: 130),
            newGameButton.heightAnchor.constraint(equalToConstant: 130)
            ])
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
}
    
    @objc func newGame() {
        mainViewController?.loadLevel()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let winViewController = mainStoryboard.instantiateViewController(withIdentifier: "Main") as? UIViewController {
            self.present(winViewController, animated: true, completion: nil)
        }
}
    
}
