//
//  AchievementsEnvironment.swift
//  TrezeCartas
//
//  Created by Matheus Andrade on 06/04/21.
//

import Foundation

class AchievementsEnvironment: ObservableObject {
    @Published var achievements: [Achievement] = []
    
    init() {
        reset()
    }
    
    func reset(){
        let result = Achievement.restore()
        
        if case .success(let array) = result{
            self.achievements = array.map{$0.value}
        }
    }
    
    func getAllAchievements() {
        // do the magic
    }
}
