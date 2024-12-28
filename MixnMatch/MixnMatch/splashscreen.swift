//
//  splashscreen.swift
//  MixnMatch
//
//  Created by Rishi Saimshu Reddy Bandi on 3/7/24.
//

import SwiftUI

struct ShowSplashScreen: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            WalkthroughScreen()
        }else {
            SplashScreen(isActive: $isActive)
        }
    }
}


struct SplashScreen: View {
    @State private var scale = 0.5
    @Binding var isActive: Bool
    var body: some View {
        VStack {
            VStack {
                VStack{
                    Image("logo")
                        .font(.system(size: 100))
                        .foregroundColor(.blue)
                    Text("MixNMatch")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                }.padding(.bottom)
                VStack{
                    Text("Prudhvi Teja Puli").font(.system(size: 15))
                        .fontWeight(.bold)
                    Text("Rishi Saimshu Reddy Bandi").font(.system(size: 15))
                        .fontWeight(.bold)
                }.padding(.top)
            }.scaleEffect(scale)
            .onAppear{
                withAnimation(.easeIn(duration: 0.7)) {
                    self.scale = 1
                }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct WalkthroughView: View {
    @AppStorage("currentPage") var currentPage = 1
    var body: some View {
     
        if currentPage > totalPages{
            ContentView()
        }
        else{
            WalkthroughScreen()
        }
    }
}

struct WalkthroughView_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughView()
    }
}


struct Home: View {
    
    var body: some View{
        
        Text("Welcome To Home !!!")
            .font(.title)
            .fontWeight(.heavy)
    }
}


struct WalkthroughScreen: View {
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View{
        
        ZStack{
            if currentPage == 1{
                ScreenView(image: "image1", title: "Step 1", detail: "heroo", bgColor: Color("color1"))
                    .transition(.scale)
            }
            if currentPage == 2{
            
                ScreenView(image: "image2", title: "Step 2", detail: "more heroo", bgColor: Color("color1"))
                    .transition(.scale)
            }
            
            if currentPage == 3{
                
                ScreenView(image: "image3", title: "Step 3", detail: "most heroo", bgColor: Color("color1"))
                    .transition(.scale)
            }
            
        }
        .overlay(

            Button(action: {
                withAnimation(.easeInOut){
                    if currentPage <= totalPages{
                        currentPage += 1
                    }
                }
            }, label: {
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        ZStack{
                            
                            Circle()
                                .stroke(Color.black.opacity(0.04),lineWidth: 4)
                                
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color.white,lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    )
            })
            .padding(.bottom,20)
            
            ,alignment: .bottom
        )
    }
}

struct ScreenView: View {
    
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        VStack(spacing: 20){
            
            HStack{
                if currentPage == 1{
                    Text("Hello Member!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                }
                else{
                    Button(action: {
                        withAnimation(.easeInOut){
                            currentPage -= 1
                        }
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    })
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut){
                        currentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.2)
                })
            }
            .padding()
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            Text(detail)
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 120)
        }
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}

var totalPages = 3

