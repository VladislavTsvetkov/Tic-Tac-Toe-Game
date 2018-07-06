//
//  ViewController.swift
//  TicTacGame
//
//  Created by Владислав Цветков on 06.07.2018.
//  Copyright © 2018 Владислав Цветков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Outlets
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgainBtn: UIButton!
    
    //Variables
    var activeGame = true
    var activePlayer = 1 // 1 - noughts, 2 - crosses
    var gameState = Array(repeating: 0, count: 9)
    
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],
                               [0,3,6],[1,4,7],[2,5,8],
                               [0,4,8], [2,4,6]]
    
    //Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideLabelAndBtn()
    }

    func hideLabelAndBtn() {
        winnerLabel.isHidden = true
        playAgainBtn.isHidden = true
        
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500 , y: winnerLabel.center.y)
        playAgainBtn.center = CGPoint(x: playAgainBtn.center.x - 500, y: playAgainBtn.center.y)
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        
        let acrivePosition = sender.tag - 1
        
        if gameState[acrivePosition] == 0 && activeGame {
        
            gameState[acrivePosition] = activePlayer
            
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "nought.png"), for: [])
                activePlayer = 2
                
            } else {
                sender.setImage(UIImage(named: "cross.png"), for: [])
                activePlayer = 1
            }
         
            for combination in winningCombinations {
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                    
                    activeGame = false
                    
                    winnerLabel.isHidden = false
                    playAgainBtn.isHidden = false
                    
                    if gameState[combination[0]] == 1 {
                        winnerLabel.text = "Noughts has won!"
                    } else {
                        winnerLabel.text = "Crosses has won!"
                    }
                    
                    UIView.animate(withDuration: 0.3) {
                        self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
                        self.playAgainBtn.center = CGPoint(x: self.playAgainBtn.center.x + 500, y: self.playAgainBtn.center.y)
                    }
                }
            }
        }
    }
    
    @IBAction func playAgainBtnPressed(_ sender: Any) {
        activeGame = true
        activePlayer = 1 // 1 - noughts, 2 - crosses
        gameState = Array(repeating: 0, count: 9)
        
        for i in 1 ..< 10 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
        }
        hideLabelAndBtn()
    }
    

}

