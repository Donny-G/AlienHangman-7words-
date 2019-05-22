//
//  GameOverViewController.swift
//  Milestone 3. HangMan
//
//  Created by Donny G on 09/05/2019.
//  Copyright © 2019 Donny G. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
   var mainViewController: ViewController?
    
    override func loadView() {
        view = UIView()
        
        let gameOverImageView1 = UIImageView()
        gameOverImageView1.translatesAutoresizingMaskIntoConstraints = false
        gameOverImageView1.image = UIImage(named: "gameover.jpg")
        view.addSubview(gameOverImageView1)
        
        let gameOverImageView2 = UIImageView()
        gameOverImageView2.translatesAutoresizingMaskIntoConstraints = false
        gameOverImageView2.image = UIImage(named: "gameover.png")
        view.addSubview(gameOverImageView2)
        
        let newGameButton = UIButton(type: .system)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.setBackgroundImage(UIImage(named: "tryagain.jpg"), for: .normal)
        newGameButton.addTarget(self, action: #selector(newGame), for: .touchUpInside)
        view.addSubview(newGameButton)
        
        NSLayoutConstraint.activate([
            gameOverImageView1.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            gameOverImageView1.widthAnchor.constraint(equalToConstant: 400),
            gameOverImageView1.heightAnchor.constraint(equalToConstant: 400),
            
            
            gameOverImageView2.topAnchor.constraint(equalTo: gameOverImageView1.bottomAnchor),
            gameOverImageView2.widthAnchor.constraint(equalToConstant: 150),
            gameOverImageView2.heightAnchor.constraint(equalToConstant: 150),
            gameOverImageView2.bottomAnchor.constraint(equalTo: newGameButton.topAnchor),
            gameOverImageView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            newGameButton.topAnchor.constraint(equalTo: gameOverImageView2.bottomAnchor),
            newGameButton.widthAnchor.constraint(equalToConstant: 150),
            newGameButton.heightAnchor.constraint(equalToConstant: 150),
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
    ])
        
}
    
    @objc func newGame(){
        mainViewController?.loadLevel()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let winViewController = mainStoryboard.instantiateViewController(withIdentifier: "Main") as? UIViewController {
            self.present(winViewController, animated: true, completion: nil)
    }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
}
    
}
