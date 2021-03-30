//
//  ContentView2.swift
//  TrezeCartas
//
//  Created by Evaldo Garcia de Souza Júnior on 06/02/21.
//
import SwiftUI
import AVFoundation
import AudioToolbox

struct GameView: View {
    
    @ObservedObject var environment = GameEnvironment()
    
    @State var leftOption: String = ""
    @State var rightOption: String = ""
    @State var leftButton = false
    @State var rightButton = false
    @State var pass = false
    
    @State var isPresentedGameOver = false
    @State var isPresentedFinished = false
    @Binding var rootIsActive : Bool
    @State var end = false
    @State var description = ""
    
    @State var isCardShowingBack = false
    
    @State var areButtonsActive = true
    @State var showConfig = false
    
    var deck: String = "" {
        didSet {
            self.environment.currentDeck = self.deck
            self.environment.objectWillChange.send()
        }
    }
    
    @AppStorage("acessibility") var isAcessibilityOn : Bool = false
    
    /// Return the CardViews width for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(environment.cards.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    /// Return the CardViews frame offset for the given offset in the array
    /// - Parameters:
    ///   - geometry: The geometry proxy of the parent
    ///   - id: The ID of the current user
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(environment.cards.count - 1 - id) * 8 // era 10
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack {
                    Spacer()
                    // status
                    VStack {
                        
                        ProgressBarView(environment: environment, showAttributes: environment.maxID < 19).frame(minHeight: 45)
                            .frame(height: geometry.size.height*0.0558)
                        
                    }
                    .padding()
                    
                    if !isAcessibilityOn {
                        Spacer().frame(height: 38)
                    }
                    
                    ZStack {
                        
                        VStack {
                            Image("logo2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width, height: geometry.size.height*0.6, alignment: .center).opacity(0.3)
                            
                        }
                        .frame(maxHeight: geometry.size.height*0.6, alignment: .center)
                        .frame(height: 500)
                        
                        ForEach(1..<self.environment.cards.count, id: \.self) { index in //era 0 em vez de 1
                            /// Using the pattern-match operator ~=, we can determine if our
                            /// user.id falls within the range of 6...9
                            if let card = self.environment.cards[index]{
                                if (self.environment.maxID - 3)...self.environment.maxID ~= card.id {
                                    CardView(card: card, onRemove: { removedCard in
                                        // Remove that card from our array
                                        if end {
                                            self.isPresentedGameOver.toggle()
                                            
                                            UserDefaults.standard.setValue(true, forKey: "has_completed_onboarding_once_key")
                                            //self.environment.reset()
                                        } else {
                                            environment.changeCardPriority()
                                            
                                            if environment.maxID == 0 {
                                                self.isPresentedFinished.toggle()
                                                
                                                UserDefaults.standard.setValue(true, forKey: "has_completed_onboarding_once_key")
                                                //self.environment.reset()
                                            }
                                            else{
                                                self.environment.cards.removeLast()
                                            }
                                            
                                        }
                                    }, environment: environment, leftOption: $leftOption, rightOption: $rightOption, end: $end, isCardShowingBack: $isCardShowingBack, leftButton: $leftButton, rightButton: $rightButton, pass: $pass)
                                    .animation(.spring())
                                    .frame(maxHeight: geometry.size.height*(isAcessibilityOn ? 0.6 : 0.7), alignment: .top)
                                    .frame(width: self.getCardWidth(geometry, id: card.id), height: 535)
                                    .offset(x: 0, y: self.getCardOffset(geometry, id: card.id))
                                    
                                }
                            }
                        }
                    }
                    .frame(height: geometry.size.height*0.6, alignment: .center)
                    
                    Spacer().frame(height: 38)
                    
                    if isAcessibilityOn {
                        if !self.isCardShowingBack {
                            
                            HStack {
                                
                                Button(action: {
                                    self.areButtonsActive = false
                                    self.leftButton.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.areButtonsActive = true
                                    }
                                }, label: {
                                    HStack {
                                        Spacer()
                                        Text(leftOption)
                                            //.font(.custom("Raleway-Bold", size: 18))
                                            .font(.callout) // era 20
                                            .fontWeight(.semibold)
                                            .foregroundColor(.brancoColor)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                            .padding(7)
                                        Spacer()
                                    }
                                    
                                }).frame(height: 55)
                                .clipped()
                                .background(Color.roxoClaroColor)
                                .cornerRadius(10)
                                .disabled(!areButtonsActive)
                                
                                Spacer()
                                    .frame(width: 7)
                                
                                Button(action: {
                                    self.areButtonsActive = false
                                    self.rightButton.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                        self.areButtonsActive = true
                                    }
                                }, label: {
                                    HStack {
                                        Spacer()
                                        Text(rightOption)
                                            .font(.callout) // era 20
                                            .fontWeight(.semibold)
                                            .foregroundColor(.brancoColor)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                            .padding(7)
                                        Spacer()
                                    }
                                    
                                }).frame(height: 55)
                                .clipped()
                                .background(Color.roxoClaroColor)
                                .cornerRadius(10)
                                .disabled(!areButtonsActive)
                            }
                            
                        } else {
                            
                            Button(action: {
                                self.pass.toggle()
                                self.areButtonsActive = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    self.areButtonsActive = true
                                }
                            }, label: {
                                HStack {
                                    Spacer()
                                    Text(end ? "Eita..." : "Bora Dale")
                                        //.font(.custom("Raleway-Bold", size: 18))
                                        .font(.callout) // era 20
                                        .fontWeight(.semibold)
                                        .foregroundColor(.brancoColor)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        .padding(7)
                                    Spacer()
                                }
                                
                            }).frame(height: 55)
                            .clipped()
                            .background(Color.roxoClaroColor)
                            .cornerRadius(10)
                            .disabled(!self.areButtonsActive)
                            
                        }
                    }
                    Spacer()
                    
                    
                    HStack {
                        HStack {
                            Image("lata")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: (geometry.size.height<600) ? 36 : 50)
                                .clipped()
                                .cornerRadius(10)
                                .padding(.trailing, -10)
                            Text((geometry.size.height<600) ? "Agite para o sucesso" : "Agite para\no sucesso")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.pretoColor)
                                .lineLimit(2)
                                .padding(.top, 4.0)
                        }.padding()
                    }
                    .opacity(environment.maxID < 17 ? 1 : 0)
                    .animation(.easeInOut(duration: 0.6))
                    .opacity(end ? 0 : 1)
                    //Spacer()
                }
                .blur(radius: CGFloat(environment.attributes.insanityStats!)/2)
                
                VStack (alignment: .trailing) {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.showConfig.toggle()
                        }, label: {
                            Image(systemName: "pause.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(minHeight: 25)
                                .frame(height: UIScreen.main.bounds.height*0.035)
                                .foregroundColor(Color.roxoClaroColor)
                            //.padding(6)
                        })
                        .padding(.top)
                        .padding(.top, UIScreen.main.bounds.height > 800 ? UIScreen.main.bounds.height*0.02 : 0)
                        .disabled(end)
                        .opacity(end ? 0 : 1)
                    }
                    
                    Spacer()
                }
                
                /// config / pause
                VStack {
                    Spacer()
                    ConfigurationView(gameViewIsActive: $rootIsActive, showConfig: $showConfig, environment: environment, isPause: true)
                        .offset(y: self.showConfig ? 0 : UIScreen.main.bounds.height)
                        .padding(.bottom)
                        .padding(.bottom) // sao dois mesmo hehe
                }
                .background(VisualEffectView(effect: UIBlurEffect(style: .dark))
                                .edgesIgnoringSafeArea(.all)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .opacity((self.showConfig ? 1 : 0)))
                
            }
            .animation(.default)
        }
        .onChange(of: end, perform: { value in
            if environment.attributes.isGameOver() {
                self.description = environment.attributes.endGame ?? "Vacilou Grandão, mermão."
            } else if environment.attributes.healthStats == 0 {
                self.description = "Bicha, nem assim tu sobrevive um rolê na 13! Bora se preparar pra o ano que vem pois o estrago vai ser grande!"
            } else if environment.attributes.moneyStats == 0 {
                self.description = "Bicha, cadê teu aqué? Se tu gastar demais não consegue voltar pra casa, demônia!"
            } else if environment.attributes.insanityStats == 10 {
                self.description = "Viado, tu já desse pt de novo, foi? Melhor sorte no próximo carnaval, se não tiver pandemia."
            }
        })
        .saturation(end ? 0 : 1)
        .navigationTitle(Text(""))
        .navigationBarBackButtonHidden(end ? true : false)
        .preferredColorScheme(.light)
        //.blur(radius: CGFloat(environment.attributes.insanityStats!)/2)
        .padding()
        .background(Color.brancoColor)
        .edgesIgnoringSafeArea(.all)
        .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification)) { _ in
            //self.drugs += 1
            if !end {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                //self.environment.attributes.insanityStats! += 1
                self.environment.setStatusShake()
            }
            if environment.attributes.insanityStats! == 10 {
                self.description = "Viado, tu já desse pt de novo, foi? Melhor sorte no próximo carnaval, se não tiver pandemia."
                self.isPresentedGameOver.toggle()
                
            }
            self.environment.objectWillChange.send()
        }
        .overlay(EndGameView(shouldPopToRootView: self.$rootIsActive, description: $description, environment: environment).opacity(isPresentedGameOver ? 1 : 0).animation(.easeInOut(duration: 0.3)))
        .overlay(FinalGameView(shouldPopToRootView: self.$rootIsActive, environment: environment).opacity(isPresentedFinished ? 1 : 0).animation(.easeInOut(duration: 0.3)))
    }
}
struct GameView_PreviewProvider: PreviewProvider{
    
    @State static var active = false
    
    static var previews: some View{
        GameView(rootIsActive: $active)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        
        GameView(rootIsActive: $active)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
        
        GameView(rootIsActive: $active)
            .previewDevice(PreviewDevice(rawValue: "iPod touch (7th generation)"))
        
        GameView(rootIsActive: $active)
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
