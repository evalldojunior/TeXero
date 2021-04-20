//
//  FinalGame.swift
//  TrezeCartas
//
//  Created by Wilton Ramos on 11/02/21.
//

import SwiftUI

struct FinalGameView: View {
    
    @Binding var shouldPopToRootView : Bool
    @ObservedObject var environment : GameEnvironment
    @Binding var isPresentedFinished : Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom){
                VStack{
                    Spacer()
                    // substituir a foto depois
                    Image("lata1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: UIScreen.main.bounds.height * 0.20)
                        .clipped()
                    Text("Você sobreviveu!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.brancoColor)
                        .multilineTextAlignment(.center)
                    Text("Parabéns! Talvez não tenha restado dignidade, mas você conseguiu sobreviver a mais um Carnaval na 13.")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.brancoColor)
                        .multilineTextAlignment(.center)
                        .frame(width: 250)
                        .padding()
                    Spacer()
                }
                
                VStack(alignment: .center){
                    
                    Spacer()
                    
                    Button(action: {
                        self.isPresentedFinished.toggle()
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
                    
//                    Button(action: {
//                        // pop to root
//                        //self.environment?.reset()
//                        //print(gameViewIsActive)
//                        //self.gameViewIsActive = false
//                        //print(gameViewIsActive)
//                    }, label: {
//                        HStack {
//                            Spacer()
//                            Text("Ir para Coleção")
//                                .font(.callout)
//                                .fontWeight(.semibold)
//                                .foregroundColor(.brancoColor)
//                                .multilineTextAlignment(.center)
//                                .lineLimit(2)
//                                .padding(7)
//                            Spacer()
//                        }
//
//                    }).frame(height: 55)
//                    .clipped()
//                    .background(Color.azulColor)
//                    .cornerRadius(10)
//
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
                .padding(.bottom, 10)
                
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(
                Image("confetes")
                    .resizable()
                    .scaledToFill()
            )
            .background(Color("roxoClaro"))
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .preferredColorScheme(.light)
    }
}

//struct FinalGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            FinalGameView()
//            FinalGameView()
//                .previewDevice("iPhone SE (2nd generation)")
//        }
//    }
//}
