//
//  ViewController.swift
//  Milestone 3. HangMan
//
//  Created by Donny G on 04/05/2019.
//  Copyright © 2019 Donny G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gif: UIImageView!
    var scoreLabel: UILabel!
    var scoreSave: Int!
    var score = 0{
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var levelLabel: UILabel!
    var level = 1 {
        didSet{
            levelLabel.text = "Level: \(level)"
        }
    }
    var clues: UILabel!
    var cluesArray = [String]()
    var clue: String!
    
    var mysteryWordLabel: UILabel!
    var mysteryWords = [String]()
    var mysteryWord: String!
    
    var letterButtons = [UIButton]()
    var usedLetters = [String]()
    var tappedLetters: String!
    
    var alienStagesImageViewArray: [UIImage] = [
        UIImage(named: "stage0.jpg")!,
        UIImage(named: "stage1.jpg")!,
        UIImage(named: "stage2.jpg")!,
        UIImage(named: "stage3.jpg")!,
        UIImage(named: "stage4.jpg")!,
        UIImage(named: "stage5.jpg")!,
        UIImage(named: "stage6.jpg")!,
        UIImage(named: "stage7.JPG")!,
    ]
    var newGameImage = UIImage(named: "stage0.jpg")
    var alienStagesImageView: UIImageView!
    var index = 0
    var lifesLabel: UILabel!
    var lifes = 7 {
        didSet {
            lifesLabel.text = "Life: \(lifes)"
            alienStagesImageView.image = alienStagesImageViewArray[index + 1]
        }
    }
    var usedLifes: Int!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "back2.jpg")!)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: \(score)"
        scoreLabel.textColor = .green
        scoreLabel.textAlignment = .right
        view.addSubview(scoreLabel)
        
        levelLabel = UILabel()
        levelLabel.textColor = .green
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.text = "Level: 1"
        levelLabel.textAlignment = .right
        view.addSubview(levelLabel)
        
        lifesLabel = UILabel()
        lifesLabel.textColor = .green
        lifesLabel.translatesAutoresizingMaskIntoConstraints = false
        lifesLabel.text = "Life: \(lifes)"
        lifesLabel.textAlignment = .right
        view.addSubview(lifesLabel)
        
        let newGameButton = UIButton(type: .system)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        newGameButton.tintColor = .red
        newGameButton.setTitle("New game", for: .normal)
        newGameButton.addTarget(self, action: #selector(newGame), for: .touchUpInside)
        view.addSubview(newGameButton)
        
        let hintLabel = UILabel()
        hintLabel.textColor = .green
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.text = "HINT:"
        view.addSubview(hintLabel)
        
        alienStagesImageView = UIImageView()
        alienStagesImageView.image = alienStagesImageViewArray[0]
        alienStagesImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alienStagesImageView)
        
        clues = UILabel()
        clues.textColor = .green
        clues.translatesAutoresizingMaskIntoConstraints = false
        clues.text = ""
        view.addSubview(clues)
        
        let lettersView = UIView()
        lettersView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lettersView)
        mysteryWordLabel = UILabel()
        mysteryWordLabel.textColor = .green
        mysteryWordLabel.layer.borderWidth = 2
        mysteryWordLabel.layer.borderColor = UIColor.yellow.cgColor
        mysteryWordLabel.font = UIFont.systemFont(ofSize: 30)
        mysteryWordLabel.translatesAutoresizingMaskIntoConstraints = false
        mysteryWordLabel.textAlignment = .center
        mysteryWordLabel.text = ""
        view.addSubview(mysteryWordLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: levelLabel.layoutMarginsGuide.trailingAnchor, constant: 90),
            
            levelLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            levelLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -150),
            
            lifesLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            lifesLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            newGameButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            newGameButton.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            newGameButton.heightAnchor.constraint(equalToConstant: 23),
            hintLabel.topAnchor.constraint(equalTo: newGameButton.bottomAnchor, constant: 10),
            hintLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
         
            clues.topAnchor.constraint(equalTo: newGameButton.bottomAnchor, constant: 10),
            clues.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 50),
            
            mysteryWordLabel.widthAnchor.constraint(equalToConstant: 400),
            mysteryWordLabel.heightAnchor.constraint(equalToConstant: 50),
            mysteryWordLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            mysteryWordLabel.topAnchor.constraint(equalTo: newGameButton.bottomAnchor, constant: 40),
        
            alienStagesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alienStagesImageView.topAnchor.constraint(equalTo: mysteryWordLabel.bottomAnchor, constant: 10),
            alienStagesImageView.heightAnchor.constraint(equalToConstant: 350),
            alienStagesImageView.widthAnchor.constraint(equalToConstant: 250),
            
            lettersView.widthAnchor.constraint(equalToConstant: 350),
            lettersView.heightAnchor.constraint(equalToConstant: 500),
            lettersView.topAnchor.constraint(equalTo: alienStagesImageView.bottomAnchor),
            lettersView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lettersView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 5)
            ])
    
        let letterWidth = 50
        let letterHeight = 70
        for row in 0..<4 {
            for col in 0..<7 {
            let letterButton = UIButton(type: .system)
                letterButton.setTitle("X", for: .normal)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            let frame = CGRect(x: col * letterWidth, y: row * letterHeight, width: letterWidth, height: letterHeight)
            letterButton.frame = frame
            lettersView.addSubview(letterButton)
                letterButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
            letterButtons.append(letterButton)
            }
        }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            self?.loadLevel()
            self?.loadButtons()
    }
}
    
  @objc  func loadLevel() {
        if let urlForLevel = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
            if let contentsOfLevel = try? String(contentsOf: urlForLevel){
                 mysteryWords = contentsOfLevel.components(separatedBy: "\n")
                cluesArray = contentsOfLevel.components(separatedBy: "\n")
            }
        }
    DispatchQueue.main.async {
        [weak self] in
    
    self?.mysteryWords.removeFirst()
        self?.mysteryWords.shuffle()
        self?.mysteryWord = self?.mysteryWords.randomElement()
        self?.clue = self?.cluesArray.first
        self?.clues.text = self?.clue
        self?.mysteryWordLabel.text = "Guess the word"
        self?.usedLetters.removeAll()
        self?.usedLifes = 0
        self?.lifes = self!.mysteryWord.count
        self?.alienStagesImageView.image = self?.newGameImage
        for button in self!.letterButtons {
            button.isHidden = false
        }
    }
}

    func loadButtons() {
       var buttonTitles = [String]()
        if let urlForAlphabet = Bundle.main.url(forResource: "alphabet", withExtension: "txt"){
            if let contentsOfAlphabet = try? String(contentsOf: urlForAlphabet){
                buttonTitles = contentsOfAlphabet.components(separatedBy: "\n")
           }
        }
        DispatchQueue.main.async {
            [weak self] in
        
        if buttonTitles.count == self?.letterButtons.count {
            for i in 0 ..< self!.letterButtons.count {
                self?.letterButtons[i].setTitle(buttonTitles[i], for: .normal)
                self?.letterButtons[i].setTitleColor(UIColor.green, for: .normal)
                //hiding unused buttons
                self?.letterButtons[26].isHidden = true
                self?.letterButtons[27].isHidden = true
                for button in self!.letterButtons{
                    button.backgroundColor = .red
                    button.layer.borderColor = UIColor.yellow.cgColor
                    button.layer.borderWidth = 5
                    button.layer.cornerRadius = button.frame.size.height/1.7
                }
            }
        }
    }
}
    
    @objc func tapButton(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else {return}
        tappedLetters = ""
        usedLetters.append(buttonTitle)
            for letter in mysteryWord {
                let strLetter = String(letter)
                if usedLetters.contains(strLetter) {
                    tappedLetters += strLetter
                } else {
                    tappedLetters += "?"
                }
            }
        
        if tappedLetters == mysteryWord  {
            scoreSave = mysteryWord.count - usedLifes
            score += scoreSave
            if level == 3 { win()}
            else {
            let ac = UIAlertController(title: "WIN", message: "Are you ready for next level", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Next", style: .default, handler: nextLevel))
            present(ac,animated: true)
            ac.view.backgroundColor = .green
        }
    }
        if !mysteryWord.contains(buttonTitle){
            lifes -= 1
            usedLifes += 1
            index += 1
        }
        if lifes == 0 {
            gameOver()
        }
       mysteryWordLabel.text = tappedLetters
       sender.isHidden = true
}
    
func win() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let winViewController = mainStoryboard.instantiateViewController(withIdentifier: "Win") as? UIViewController {
            self.present(winViewController, animated: true, completion: nil)
        }
}
    
    func gameOver() {
        let mainStotyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let gameOverViewController = mainStotyboard.instantiateViewController(withIdentifier: "GameOver") as? UIViewController {
            self.present(gameOverViewController, animated: true, completion: nil)
        }
}
    
    @objc func newGame (){
        level = 1
        index = 0
        loadLevel()
        loadButtons()
}
    
    @objc func nextLevel(action: UIAlertAction){
        level += 1
        index = 0
    loadLevel()
    loadButtons()
}

}











