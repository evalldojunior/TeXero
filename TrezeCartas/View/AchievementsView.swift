//
//  AchievementsView.swift
//  TrezeCartas
//
//  Created by Matheus Andrade on 06/04/21.
//

import SwiftUI

struct AchievementsView: View {
    @ObservedObject var environment = AchievementsEnvironment()
    
    @Binding var isActive: Bool
    
    init(isActive: Binding<Bool>){
        _isActive = isActive
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack{
                GeometryReader{ geometry in
                    HStack(alignment: .center){
                        Spacer()
                        Image("conquistas_item")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height, alignment: .center)
                        Spacer()
                    }
                    .padding(.top)
                }
                .frame(height: 85)
                .padding(.bottom, 50)

                ScrollView(.vertical) {
                    LazyVStack(alignment: .center, spacing: 10) {
                        ForEach(0..<self.environment.achievements.count, id: \.self) { index in
                            AchievementCardView(achievement: self.environment.achievements[index])
                        }
                    }
                }
                
                //Spacer()
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
            self.environment.reset()
        })
        .onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
        
        
    }
}

struct AchievementCardView: View {
    var achievement: Achievement
    
    var body: some View {
        ZStack {
            CardAchievementArt()
            
            VStack {
                Text(achievement.title)
                    .font(.title3)
                    .foregroundColor(.amareloColor)
                
                Spacer()
                
                Text(achievement.description)
                    .font(.caption2)
                    .foregroundColor(.brancoColor)
                
            }
            .padding()
        }
        .padding(10)
        .clipped()
        .frame(width: UIScreen.main.bounds.width*0.9, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.verdeColor)
        .cornerRadius(10)
        
    }
}

struct CardAchievementArt: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.roxoColor, lineWidth: 2.0)
                )
            VStack {
                HStack {
                    CardAchievementCircle()
                    Spacer()
                    CardAchievementCircle()
                }
                
                Spacer()
                HStack {
                    CardAchievementCircle()
                    Spacer()
                    CardAchievementCircle()
                }
            }
        }
    }
}

struct CardAchievementCircle: View {
    
    var body: some View {
        Circle()
            .frame(width: 9, height: 9, alignment: .center)
            .foregroundColor(Color.amareloColor)
            .padding(6)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.roxoColor, lineWidth: 2.0)
            )
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
