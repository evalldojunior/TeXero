//
//  EndGame.swift
//  TrezeCartas
//
//  Created by Evaldo Garcia de Souza Júnior on 10/02/21.
//

import Foundation
import SwiftUI

struct EndGameView: View {

    @Binding var shouldPopToRootView : Bool
    @Binding var description: String
    @Binding var isPresentedGameOver : Bool
    
    @ObservedObject var environment : GameEnvironment
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom){
                VStack{
                    Spacer()
                    // substituir a foto depois
                    Image("caveira1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: UIScreen.main.bounds.height * 0.20)
                        .padding(.bottom)
                        .clipped()
                    Text("Game Over!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.brancoColor)
                        .multilineTextAlignment(.center)
                    Text("\(description)")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.brancoColor)
                        .multilineTextAlignment(.center)
                        .frame(width: 230)
                        .padding()
                    Spacer()
                    
                    VStack(alignment: .center){
                        
                        //Spacer()
                        
                        Button(action: {
                            self.isPresentedGameOver.toggle()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Jogar Novamente")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.brancoColor)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .padding(7)
                                Spacer()
                            }
                            
                        }).frame(height: 55)
                        .clipped()
                        .background(Color.rosaColor)
                        .cornerRadius(10)
                        
                        Button(action: {
                            self.environment.reset()
                            self.environment.objectWillChange.send()
                            self.shouldPopToRootView = false
                            
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Retornar ao Menu Principal")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.rosaColor)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .padding(7)
                                Spacer()
                            }
                            
                        }).frame(height: 55)
                        .clipped()
                        .background(Color.brancoColor)
                        .cornerRadius(10)
                        
                    }.padding()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }
        .preferredColorScheme(.light)
        .statusBar(hidden: true)
    }
}

//struct EndGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        EndGame(description: "Você deu pt. Melhor sorte no próximo carnaval, se não tiver pandemia.")
//    }
//}
