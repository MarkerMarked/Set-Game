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
        //Load first 12 cards
        updateView()
        
    }
    
    let game = Set()
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func pressNewGame(_ sender: UIButton) {
        
    }
    
    @IBAction func pressDeal(_ sender: UIButton) {
        
    }
    
    @IBAction func pressCard(_ sender: UIButton) {
        
    }
    
    func updateView () {
        for buttonIndex in cardButtons.indices {
            print(buttonIndex)
            
            let button = cardButtons[buttonIndex]
            if game.cardsPlayed.count > buttonIndex {
                
                //Configure NSAttributes
                var attributes = [NSAttributedStringKey:Any]()
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
                button.setAttributedTitle(NSAttributedString(string: shapeString, attributes: attributes), for: UIControlState.normal)
            }
            else {
                //Make the button invisible and untouchable
                button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                button.isEnabled = false
            }
        }
    }
}


