//
//  CollageEnvironment.swift
//  TrezeCartas
//
//  Created by Nádia Bordoni on 29/03/21.
//

import Foundation

class CollageEnvironment: ObservableObject {
    @Published var cards: [JSONCard] = []
    @Published var areCardsDiscovered: [Bool] = []
    
    init() {
        reset()
    }
    func reset(){
        guard let jsonPath = Bundle.main.path(forResource: "TeXeroNa13", ofType: "txt") else { fatalError() }
        
        do {
            let jsonData = try String(contentsOfFile: jsonPath, encoding: String.Encoding.utf8).data(using: String.Encoding.utf8)!
            cards = try JSONDecoder().decode([JSONCard].self, from: jsonData)
            cards.remove(at: 1)
            
            if let discoveredCards = UserDefaults.standard.array(forKey: "has_discovered_cards_key") as? [Int] {
                areCardsDiscovered = cards.map{ card in
                    if discoveredCards.contains(card.uid){
                        return true
                    } else {
                        return false
                    }
                }
            } else {
                areCardsDiscovered = cards.map{ card in
                    return false
                }
            }
            
        }
        catch {
            print(error)
        }
    }
}
