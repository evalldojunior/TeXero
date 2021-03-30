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
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack{
                GeometryReader{ geometry in
                    HStack(alignment: .center){
                        Spacer()
                        Image("estrela")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width*0.15, height: geometry.size.width*0.15, alignment: .center)
                        Text("Coleção")
                            .font(.custom("Mojito+-+Regular", size: 40))
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color("pretoEscuro")/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    .padding(.top)
                }.frame(height: 85)
                ScrollView() {
                    LazyVGrid(columns: [GridItem(), GridItem()], alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 16){
                        ForEach((0..<environment.cards.count), id: \.self){
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
                    }.padding()
                }
            }
            Button(action: {
                isActive = false
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color("roxoClaro")/*@END_MENU_TOKEN@*/)
                    .frame(width: 20, height: 20)
            }.padding()
        }
    }
}
struct CollageView_Previews: PreviewProvider {
    static var previews: some View {
        CollageView(isActive: .constant(true))
            .previewDevice("iPhone 11")
    }
}
