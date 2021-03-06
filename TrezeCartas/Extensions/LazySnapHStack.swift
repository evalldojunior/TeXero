//
//  AppDelegate.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 27/11/20.
//
import SwiftUI

struct LazySnapHStack<Elements, Content>: View
where Elements: RandomAccessCollection, Content: View {
    
    var data: Elements
    
    @State var offset : CGFloat = 0
    @State var width = UIScreen.main.bounds.width - 70
    @State var height: CGFloat = UIScreen.main.bounds.height*0.6
    @State private var op : CGFloat = 0
    
    @State private var count : CGFloat = 0
    @State private var isDisplayed: [Bool] = []
    
    var content: (Elements.Element) -> Content
    
    func getIsDisplayed(of index: Int) -> Bool{
        if isDisplayed.count > index{
            return isDisplayed[index]
        }
        else{
            return false
        }
    }
    var body : some View{
        
        LazyHStack(spacing: 15){
            
            ForEach(0..<self.data.count, id: \.self){index in
                
                content(data[index as! Elements.Index])
                    .frame(width: width, height: self.getIsDisplayed(of: index) ? height : height*0.85)
                    .offset(x: self.offset)
                    .highPriorityGesture(
                        DragGesture()
                            .onChanged({ (value) in
                                
                                if value.translation.width > 0{
                                    
                                    self.offset = value.location.x
                                }
                                else{
                                    
                                    self.offset = value.location.x - self.width
                                }
                                
                            })
                            .onEnded({ (value) in
                                
                                if value.translation.width > 0{
                                    
                                    if value.translation.width > ((self.width - 80) / 2) && Int(self.count) != 0{
                                        
                                        self.count -= 1
                                        self.updateHeight(value: Int(self.count))
                                        self.offset = -((self.width + 15) * self.count)
                                    }
                                    else{
                                        
                                        self.offset = -((self.width + 15) * self.count)
                                    }
                                }
                                else{
                                    
                                    if -value.translation.width > ((self.width - 80) / 2) && Int(self.count) !=  (self.data.count - 1){
                                        
                                        self.count += 1
                                        self.updateHeight(value: Int(self.count))
                                        self.offset = -((self.width + 15) * self.count)
                                    }
                                    else{
                                        
                                        self.offset = -((self.width + 15) * self.count)
                                    }
                                }
                            })
                    )
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .offset(x: self.op)
        .animation(.spring())
        .onAppear {
            self.isDisplayed = data.map{_ in
                return false
            }
            self.op = ((self.width + 15) * CGFloat(self.data.count / 2)) - (self.data.count % 2 == 0 ? ((self.width + 15) / 2) : 0)
            
            if !self.isDisplayed.isEmpty {
            self.isDisplayed[Int(floor(count))] = true
            }
        }
    }
    
    func updateHeight(value : Int){
        
        for i in 0..<isDisplayed.count{
            
            self.isDisplayed[i] = false
        }
        if value < isDisplayed.count{
            self.isDisplayed[value] = true
        }
    }
}
