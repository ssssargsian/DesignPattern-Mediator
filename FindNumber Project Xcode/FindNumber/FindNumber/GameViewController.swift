//
//  GameViewController.swift
//  FindNumber
//
//  Created by Rafik  on 06.11.2021.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var Buttons: [UIButton]!
 
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    lazy var  game = Game(countItems: Buttons.count,time:30){[weak self](status,time)in
        
        guard let self = self else {return}
        
        self.timerLabel.text = "\(time)"
        self.updateInfoGame(with: status)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
   
    
    @IBAction func pressbutton(_ sender: UIButton) {
        guard let buttonIndex = Buttons.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        updateUI()
       // sender.isHidden = true
      //  print(sender.currentTitle)
    }
    private func setupScreen(){
        for index in game.items.indices {
            Buttons[index].setTitle(game.items[index].title,for:.normal)
            Buttons[index].isHidden = false
            
        }
        nextDigit.text = game.nextItem?.title
       
    }
   
    private func updateUI() {
        for index in game.items.indices{
            Buttons[index].isHidden = game.items[index].ifFound
        }
        nextDigit.text = game.nextItem?.title
        updateInfoGame(with: game.status)
    }
    private func updateInfoGame(with status:StatusGame) {
        switch status {
        case .start:
            statusLabel.text = "Игра началась"
            statusLabel.textColor = .black
        case .win:
            statusLabel.text = "Вы выиграли"
            statusLabel.textColor = .green
        case .lose:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = .red
        }
    }
}
