//
//  Set! Controller
//
//  Created by Mark Johnson on 6/28/18.
//  Copyright © 2018 Mark Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dateOfLastMatch = Date()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var game = Set()
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var dealMoreButton: UIButton!
    
    @IBAction func pressNewGame(_ sender: UIButton) {
        game = Set()
        score = 0
        dateOfLastMatch = Date()
        updateView()
    }
    
    @IBAction func pressDeal(_ sender: UIButton) {
        guard game.cardsPlayed.count <= 24 else { updateView(); return}
        game.dealNewCards()
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dealMoreButton.layer.cornerRadius = 8.0
        for index in cardButtons.indices {
            cardButtons[index].layer.cornerRadius = 8.0
            cardButtons[index].layer.borderWidth = 4.0
        }
        updateView()
    }
    
    @IBAction func pressCard(_ sender: UIButton) {
        game.select(card: game.cardsPlayed[cardButtons.firstIndex(of: sender)!])
        if game.cardsSelected.count == 3 && !game.isMatch {
            score -= 10
        }
        updateView()
    }
    
    func updateView () {
        //Update score - Receive 0-30 points depending on how long it took to match a set
        if game.isMatch {
            let timeSinceLastMatch = dateOfLastMatch.timeIntervalSinceNow
            if (30-Int(abs(timeSinceLastMatch.magnitude))) > 0 { score += (30-Int(abs(timeSinceLastMatch.magnitude))) }
            dateOfLastMatch = Date()
        }
        //Update 'dealMoreButton' based on 'Number in Deck', 'Number on UI', and 'Match Status'
        if game.deck.numberInDeck != 0 && (game.cardsPlayed.count < 24 || game.isMatch) {
            dealMoreButton.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            dealMoreButton.isEnabled = true
        } else {
            dealMoreButton.isEnabled = false
            dealMoreButton.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.5)
        }
        
        for buttonIndex in cardButtons.indices {
            let button = cardButtons[buttonIndex]
            if game.cardsPlayed.count > buttonIndex {
                //Configure NSAttributes
                var attributes = [NSAttributedString.Key:Any]()
                //Configure cardsPlayed onto buttons
                let card = game.cardsPlayed[buttonIndex]
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.isEnabled = true
                var tempUIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                var shapeString: String = ""
                switch card.colorSetting {
                case .colorOne:     //RED
                    attributes[.strokeColor] = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                    attributes[.foregroundColor] = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                    tempUIColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                case .colorTwo:     //GREEN
                    attributes[.strokeColor] = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    attributes[.foregroundColor] = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    tempUIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                case .colorThree:   //PURPLE
                    attributes[.strokeColor] = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                    attributes[.foregroundColor] = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                    tempUIColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
                }
                switch card.shadeSetting {
                case .shadeOne:     //filled/solid
                    attributes[.strokeWidth] = -5.0
                case .shadeTwo:     //shaded/striped
                    attributes[.foregroundColor] = tempUIColor.withAlphaComponent(0.15)
                    //attributes[.strokeColor] = tempUIColor.withAlphaComponent(0.15)
                    attributes[.strokeWidth] = -15.0
                case .shadeThree:   //outline/open
                    attributes[.strokeWidth] = 5.0
                }
                switch card.shapeSetting{
                case .shapeOne:     //▲
                    shapeString = "▲"
                case .shapeTwo:     //■
                    shapeString = "■"
                case .shapeThree:   //●
                    shapeString = "●"
                }
                switch card.countSetting {
                case .countOne:     //one
                    break
                case .countTwo:     //two
                    shapeString.append(shapeString)
                case .countThree:   //three
                    shapeString.append(shapeString+shapeString)
                }
                button.setAttributedTitle(NSAttributedString(string: shapeString, attributes: attributes), for: UIControl.State.normal)
            }
            else {
                //Make the button invisible and untouchable
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                button.isEnabled = false
                button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
            }
            button.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
        }
        
        for selectedIndex in game.cardsSelected.indices {
            let button = cardButtons[game.cardsPlayed.firstIndex(of: game.cardsSelected[selectedIndex])!]
            button.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            
            if game.isMatch {
                button.layer.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            
            if game.cardsSelected.count == 3 && !game.isMatch {
                button.layer.backgroundColor = #colorLiteral(red: 1, green: 0.7526777961, blue: 0.7518366721, alpha: 1)
            }
        }
        //Check if card is in MatchList
        for matchIndex in game.cardsMatched.indices {
            if game.cardsPlayed.contains(game.cardsMatched[matchIndex]) {
                let button = cardButtons[game.cardsPlayed.index(of: game.cardsMatched[matchIndex])!]
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                button.isEnabled = false
                button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
            }
        }
    }
}



