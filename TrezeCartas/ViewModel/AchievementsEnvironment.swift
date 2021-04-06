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
        self.achievements = [Achievement(title: "Beijjoqueiro", description: "Beijou mais de 50 bocas em um dia de Carnaval.")]
    }
    
    func getAllAchievements() {
        // do the magic
    }
}
