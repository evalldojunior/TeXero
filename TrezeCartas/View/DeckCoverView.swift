//
//  DeckCoverView.swift
//  TrezeCartas
//
//  Created by Matheus Andrade on 29/03/21.
//

import SwiftUI

struct DeckCoverView: View {
    var body: some View {
        
        GeometryReader { geometry in
            VStack(alignment: .center) {
                ZStack {
                    CardArt(complete: true)

                    Image("TeXeroNa13Cover")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width*0.6, height: geometry.size.height*0.4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10)
                        .padding([.top, .leading, .trailing])
                        .padding([.top, .leading, .trailing], 10)
                        .clipShape(Rectangle(), style: FillStyle())
                    
                    VStack {
                        Spacer()
                        
                        Image("BotaoJogar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width*0.2, height: geometry.size.height*0.075, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding()
                    }
                    .padding()
                    
                }
                
            }
            .background(Color.brancoColor)
            .clipped()
            .cornerRadius(10)
            .shadow(radius: 5)            
        }
        
    }
}

struct DeckCoverView_Previews: PreviewProvider {
    static var previews: some View {
        DeckCoverView()
            .frame(width: 303, height: 440, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
