//
//  FirebaseHandler.swift
//  TrezeCartas
//
//  Created by Matheus Andrade on 18/03/21.
//

import SwiftUI
import FirebaseAnalytics

class FirebaseHandler {
    
    // O que queremos medir?
    // 1. Quantos usuários estão utilizando os botões de acessibilidade? -> Estão usando os botões? (FEITO)
    // 2. Quantas pessoas sairam no meio do jogo (depois de quantas rodadas)? -> Desistem por estar chato, dificil, etc? (FEITO)
    // 3. Quantas pessoas jogaram novamente? Após perder ou ganhar? -> Eles jogam até ganhar ou se animam quando ganham?
    // 4. Quanto tempo o usuário leva para passar de carta, em média? -> Eles leem as cartas completamente?
    // 5. Quantas tentativas são necessárias para vencer a primeira vez? -> Jogo fácil ou difícil? (FEITO)
    // 6. Das desinstalações, já haviam ganhado o jogo? Importante
    
    static var finishedGame: Bool = false
    static var countPlayAgain: Int = 0
    static var userWon: Bool = false
    static var timePassCard: Float = 0.0
    static var countRound: Int = 0
    
    //    class func registerButtonClicksEvent() {
    //
    //Analytics.logEvent("choice_button_clicks", parameters: ["number_of_clicks": self.countButtonClicks])
    //        print("Começou")
    //        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
    //            AnalyticsParameterItemName: "Cliques no botão",
    //            AnalyticsParameterValue: String(self.countButtonClicks),
    //            AnalyticsParameterContentType: "clicks"
    //          ])
    //        print("Terminou")
    //
    
    //self.countButtonClicks = 0
    
    //    }
    
    class func registerGaveUpGameEvent() {
        Analytics.logEvent("give_up_game", parameters: ["rounds_played": self.countRound])
        self.countRound = 0
    }
    
    class func registerWinFirstTimeEvent() {
        let attempts = UserDefaults.standard.integer(forKey: "attemptsToWin")
        Analytics.logEvent("attempts_needed_to_win", parameters: ["number_of_attempts": attempts])
    }
    
    class func registerAcessibilityButtonUseEvent() {
        let acessibility = UserDefaults.standard.bool(forKey: "acessibility")
        Analytics.logEvent("using_acessibility_buttons", parameters: ["use": acessibility])
    }
    
    class func registerPlayAgainEvent() {
        
    }
    
    class func reset() {
        self.finishedGame = false
        self.countPlayAgain = 0
        self.userWon = false
        self.timePassCard = 0.0
        self.countRound = 0
    }
    
}
