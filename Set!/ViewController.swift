//
//  Set! Controller
//
//  Created by Mark Johnson on 6/28/18.
//  Copyright © 2018 Mark Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dealMoreButton.layer.cornerRadius = 8.0
        for index in cardButtons.indices {
            cardButtons[index].layer.cornerRadius = 8.0
            cardButtons[index].layer.borderWidth = 4.0
        }
        updateView()
    }
    
    var game = Set()
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var dealMoreButton: UIButton!
    
    @IBAction func pressNewGame(_ sender: UIButton) {
        game = Set()
        updateView()
    }
    
    @IBAction func pressDeal(_ sender: UIButton) {
        guard game.cardsPlayed.count <= 24 else { updateView(); return}
        game.dealNewCards()
        updateView()
    }
    
    @IBAction func pressCard(_ sender: UIButton) {
        game.selectCard(at: cardButtons.index(of: sender)!)
        updateView()
    }
    
    func updateView () {
        if game.cardsInDeck.count != 0 && (game.cardsPlayed.count < 24 || game.isMatch) {
            dealMoreButton.backgroundColor = #colorLiteral(red: 0.8355803517, green: 0.9736485354, blue: 1, alpha: 1)
            dealMoreButton.isEnabled = true
        } else {
            dealMoreButton.isEnabled = false
            dealMoreButton.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
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
            let button = cardButtons[game.cardsSelected[selectedIndex].key]
            button.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
            
            if game.isMatch {
                button.layer.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
        }
        //Check if card is in MatchList
        for index in game.cardsMatched.indices {
            if game.cardsPlayed.contains(game.cardsMatched[index]) {
                let button = cardButtons[game.cardsPlayed.index(of: game.cardsMatched[index])!]
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                button.isEnabled = false
                button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
            }
        }
    }
}


