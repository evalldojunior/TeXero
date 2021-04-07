//
//  Achievement.swift
//  TrezeCartas
//
//  Created by Matheus Andrade on 06/04/21.
//

import Foundation

class Achievement: Codable, ReflectedStringConvertible {
    var id: String
    var title: String
    var description: String
    var completion: Double
    var isCompleted: Bool
    
    init(id: String, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
        
        self.completion = 0.0
        self.isCompleted = false
    }

    func check(condition: Bool, step: Double, reset: Bool = false){
        if isCompleted{
            return
        }
        if reset{
            self.completion = 0
        }
        if condition{
            self.completion += step
            if self.completion >= 1{
                self.isCompleted = true
            }
        }
        
        
    }
    
    class func archive(achievements: [String: Achievement]) throws{
        let data = try JSONEncoder().encode(achievements)
        UserDefaults.standard.set(data, forKey: "achievements-key")
    }
    
    
    class func restore()->Result<[String: Achievement],Error>{
        let defaults = UserDefaults.standard
        
        if let achievementsData = defaults.data(forKey: "achievements-key"){
            do{
                let achievements = try JSONDecoder().decode([String: Achievement].self, from: achievementsData)
                return .success(achievements)
            }
            catch{
                return .failure(error)
            }
            
        }
        else{
            let achievementsList = [
                Achievement(id: "beijoqueiro", title: "Beijjoqueiro", description: "Beijou mais de 50 bocas em um dia de Carnaval."),
                Achievement(id: "feioso", title: "Feioso", description: "Beijou só 2 bocas em um dia de Carnaval.")]
            let achievementsDict = achievementsList.reduce([String: Achievement]()){ dict, achv in
                var dict = dict
                dict[achv.id] = achv
                return dict
            }
            do{
                
                try Achievement.archive(achievements: achievementsDict)
                
                return .success(achievementsDict)
            }
            catch{
                return .failure(error)
            }
            
        }
        
    }
    
}
