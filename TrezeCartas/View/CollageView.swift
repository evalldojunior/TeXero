//
//  CollageView.swift
//  TrezeCartas
//
//  Created by Nádia Bordoni on 29/03/21.
//

import SwiftUI

struct CollageView: View {
    @ObservedObject var environment = CollageEnvironment()
    @Binding var isActive: Bool
    
    init(isActive: Binding<Bool>){
        _isActive = isActive
        
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.roxoColor)
        
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(.roxoColor).withAlphaComponent(0.2)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack{
                GeometryReader{ geometry in
                    HStack(alignment: .center){
                        Spacer()
                        Image("colecao_item")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height, alignment: .center)
                        Spacer()
                    }
                    .padding(.top)
                }.frame(height: 85)
                Spacer()
                TabView{
                    
                    ForEach((0..<environment.cards.count/6), id: \.self){ section in
                        
                        LazyVGrid(columns: [GridItem(), GridItem()], alignment: .center){
                            ForEach((6*section..<6*section + 6), id: \.self){
                                index in
                                if let card = environment.cards[index]{
                                    ZStack {
                                        Rectangle().fill(Color("roxo"))
                                            .cornerRadius(15.0)
                                            .frame(width: UIScreen.main.bounds.width * 0.4452)
                                        CardArt(complete: false)
                                            .padding(-10.0)
                                            .padding(.horizontal, -3)
                                            .frame(width: UIScreen.main.bounds.width * 0.4284)
                                        VStack {
                                            Image(card.imageName)
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(10.0)
                                            Spacer()
                                            Text(card.name)
                                                .font(.system(size: 13, weight: .bold, design: .default))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("amarelo"))
                                                .multilineTextAlignment(.center)
                                                .lineLimit(2)
                                                //.frame(maxHeight: 40 )
                                                .padding(.horizontal, 16.0)
                                            Spacer()
                                        }
                                        .padding([.top, .leading, .trailing])
                                        .padding(.horizontal, 3)
                                        .blur(radius: environment.areCardsDiscovered[index] ? 0 : 3.5)
                                        
                                    }.frame(minHeight: 160)
                                    .saturation(environment.areCardsDiscovered[index] ? 1 : 0)
                                }
                                
                            }
                        }
                        .padding(.bottom, 30 )
                        .padding(.horizontal)
                        
                        //.padding(.bottom, 40)
                        
                    }
                    
                    
                }
                
                .tabViewStyle(PageTabViewStyle())
                
                .ignoresSafeArea(.all, edges: .bottom)
                Spacer()
                //.background(Color.pink)
                
            }
            
            Button(action: {
                isActive = false
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.roxoColor)
                    .frame(width: 20, height: 20)
            }.padding()
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarHidden(true)
        .onAppear(perform: {
            UIScrollView.appearance().bounces = false
            self.environment.reset()
         })
        .onDisappear(perform: {
           UIScrollView.appearance().bounces = true
         })
    }
}
struct CollageView_Previews: PreviewProvider {
    static var previews: some View {
        CollageView(isActive: .constant(true))
            .previewDevice("iPhone 11")
        CollageView(isActive: .constant(true))
            .previewDevice("iPhone 8")
    }
}
