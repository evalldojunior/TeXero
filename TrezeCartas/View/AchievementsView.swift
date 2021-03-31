//
//  AchievementsView.swift
//  TrezeCartas
//
//  Created by Nádia Bordoni on 31/03/21.
//

import SwiftUI

struct AchievementsView: View {
    //@ObservedObject var environment = CollageEnvironment()
    @Binding var isActive: Bool
    
    init(isActive: Binding<Bool>){
        _isActive = isActive
        
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.roxoColor)
        
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(.roxoColor).withAlphaComponent(0.2)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    ZStack{
                        Image("calma")
                            .resizable()
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        CardArt(complete: true)
                    }
                    .frame(width: 300, height: 300, alignment: .center)
                    
                    Spacer()
                }
                Spacer()
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
        .background(Color.brancoColor.ignoresSafeArea())
        .navigationBarHidden(true)
        .onAppear(perform: {
            UIScrollView.appearance().bounces = false
            //self.environment.reset()
         })
        .onDisappear(perform: {
           UIScrollView.appearance().bounces = true
         })
    }
}
struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView(isActive: .constant(true))
            .previewDevice("iPhone 11")
        AchievementsView(isActive: .constant(true))
            .previewDevice("iPod touch (7th generation)")
    }
}
