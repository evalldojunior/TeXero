//
//  MenuDecksView.swift
//  TrezeCartas
//
//  Created by Evaldo Garcia de Souza Júnior on 25/03/21.
//

import SwiftUI

struct MenuDecksView: View {
    
    //@EnvironmentObject var appState: AppState
    @State var isPresented = false
    @Namespace var namespace
    @State var showConfig = false
    //@ObservedObject var environment: GameEnvironment
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .center){
                    
                    NavigationLink(destination: GameView(rootIsActive: self.$isPresented), isActive: $isPresented) { EmptyView()}.isDetailLink(false)
                    
                    VStack {
                        LazySnapHStack(data: [1, 2]){ item in
                            DeckCoverView()
                            .onTapGesture {
                                if !showConfig {
                                    // Definir qual deck foi clicado
                                    // ...
                                    self.isPresented.toggle()
                                }
                            }
                        }
                        Spacer().frame(height: 50)
                    }
                    .padding()
                    
                    VStack {
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {
                                // Abrir tela de conquistas
                            }, label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.azulColor, lineWidth: 2.0)
                                        )
                                        .padding(5)
                                    
                                    VStack {
                                        Image("ConquistasImage")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.height*0.07, height: geometry.size.height*0.07, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        Spacer().frame(height: 0)
                                        HStack {
                                            Spacer()
                                            Text("Conquistas")
                                                .font(UIScreen.main.bounds.height > 600 ? .callout : .caption)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.pretoColor)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(2)
                                            Spacer()
                                        }
                                    }
                                }
                            })
                            .frame(width: geometry.size.height*0.1477, height: geometry.size.height*0.1477)
                            .clipped()
                            .background(Color.brancoColor)
                            .cornerRadius(10)
                            .shadow(radius: 5)

                            Spacer()
                            
                            Button(action: {
                                // Abrir tela de coleção
                            }, label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.roxoClaroColor, lineWidth: 2.0)
                                        )
                                        .padding(5)
                                    
                                    VStack {
                                        Image("ColecaoImage")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.height*0.07, height: geometry.size.height*0.07, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        Spacer().frame(height: 0)
                                        HStack {
                                            Spacer()
                                            Text("Coleção")
                                                .font(UIScreen.main.bounds.height > 600 ? .callout : .caption)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.pretoColor)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(2)
                                            Spacer()
                                        }
                                    }
                                }
                                
                            })
                            .frame(width: geometry.size.height*0.1477, height: geometry.size.height*0.1477)
                            .clipped()
                            .background(Color.brancoColor)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            
                            Spacer()
                        }
                    }.padding()
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.showConfig.toggle()
                            }, label: {
                                Image(systemName: "ellipsis.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(minHeight: 25)
                                    .frame(height: UIScreen.main.bounds.height*0.035)
                                    .foregroundColor(Color.roxoClaroColor)
                            })
                            .padding()
                            .padding(.top, UIScreen.main.bounds.height > 800 ? UIScreen.main.bounds.height*0.02 : 0)
                        }
                        
                        Spacer()
                    }
                    .padding(.trailing)
                    
                    /// Config
                    VStack {
                        Spacer()
                        ConfigurationView(shouldPopToRootView: .constant(false), showConfig: $showConfig, isPause: false)
                            .offset(y: self.showConfig ? 0 : UIScreen.main.bounds.height)
                            .padding()
                    }
                    .background(VisualEffectView(effect: UIBlurEffect(style: .dark))
                                    .edgesIgnoringSafeArea(.all)
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .opacity((self.showConfig ? 1 : 0)))
                    .padding()
                    
                }
                .padding()
                .animation(.default)
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .edgesIgnoringSafeArea(.all)
            .background(Image("DecksBackground").resizable().scaledToFill().edgesIgnoringSafeArea(.all))
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .accentColor(Color.roxoColor)
        .navigationBarBackButtonHidden(false)
        .navigationBarHidden(true)
    }
}

struct MenuDecksView_Previews: PreviewProvider {
    static var previews: some View {
        MenuDecksView()
    }
}
