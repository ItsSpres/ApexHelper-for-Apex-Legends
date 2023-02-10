//
//  News.swift
//  apexhelperV2
//
//  Created by Ian Spresney on 9/25/22.
//
import SDWebImageSwiftUI
import SwiftUI

struct News: View {
    var image = ""
    var title = "hi"
    var bodyHtml = ""
    var author = "hi"
    var url = ""
    var postDate = "hi"
    
    @State private var showSecondView = false
        // 5. Create the instance of Writer you want to pass to SecondView
        
    
    var body: some View {
        Button(action: {
                    self.showSecondView.toggle()
                }, label: {
                
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color("cellColors"))
                .shadow(radius: 5)
                .frame(width: UIScreen.screenWidth*0.95, height: UIScreen.screenWidth)
            VStack {
                WebImage(url: URL(string: image))
                    .onSuccess { image, data, cacheType in }
                    .resizable()
                    .placeholder {
                            Rectangle().foregroundColor(.gray)
                        }
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth*0.95, height: UIScreen.screenWidth*0.65)
                    .clipped()
                    .cornerRadius(15, corners: [.topLeft, .topRight])
                VStack {
                    Text(author)
                        .foregroundColor(Color("lightGray"))
                        .fontWeight(.regular)
                        .font(.custom(mainFont, size: 14))
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.screenWidth*0.9, alignment: .leading)
                    
                    Text(title)
                        .foregroundColor(Color("textColor"))
                        .fontWeight(.bold)
                        .font(.custom(mainFont, size: 18))
                        .multilineTextAlignment(.leading)
                        .offset(y: -10)
                        .frame(width: UIScreen.screenWidth*0.90,height: UIScreen.screenWidth*0.15, alignment: .topLeading)
                    
                    
                    Text(postDate)
                        .foregroundColor(Color("lightGray"))
                        .fontWeight(.regular)
                        .font(.custom(mainFont, size: 14))
                        .multilineTextAlignment(.trailing)
                        .frame(width: UIScreen.screenWidth*0.9,alignment: .bottomTrailing)
                }
                .frame(height: UIScreen.screenWidth*0.32)
                
            }
            .frame(width: UIScreen.screenWidth*0.95, height: UIScreen.screenWidth,alignment: .top)
        }
                    
                })
                // 2. Add a sheet modifier to present SecondView modally
        .fullScreenCover(isPresented: $showSecondView){
                    // 5. Use the new SecondView initializer
                    articleView(title: title,author: author,htmlBody: bodyHtml, img: image, url: url)
                }
    }
}

struct News_Previews: PreviewProvider {
    static var previews: some View {
        News()
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
