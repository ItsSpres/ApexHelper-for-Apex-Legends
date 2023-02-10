//
//  PayWall.swift
//  Apex Helper
//
//  Created by Ian Spresney on 10/17/22.
//

import SwiftUI
import RevenueCat

struct PayWall: View {
    
    @Binding var isPayWallPresented: Bool
    
    @State var currentOffering: Offering?
    
    @State var showLoading : Bool = false
    
    @EnvironmentObject var checkAccess: CheckAccess
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("ApexHelper Pro")
                    .font(.custom(mainFont, size: 25))
                    .foregroundColor(Color("textColor"))
                    .fontWeight(.bold)
                Text("Say good bye to ads and unlock additional helpful features")
                    .font(.custom(mainFont, size: 16))
                    .foregroundColor(Color("textColor"))
                    .fontWeight(.regular)
                Spacer()
                
                VStack(alignment: .center, spacing: 40) {
                    HStack {
                        Image("no")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("Remove all Ads from the app")
                            .font(.custom(mainFont, size: 16))
                            .foregroundColor(Color("textColor"))
                            .fontWeight(.regular)
                    }
//                    HStack {
//                        Image("stats")
//                            .resizable()
//                            .frame(width: 25, height: 25)
//                        Text("Gain access to more content")
//                            .font(.custom(mainFont, size: 16))
//                            .foregroundColor(Color("textColor"))
//                            .fontWeight(.regular)
//                    }
                    HStack {
                        Image("shop")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("Unlock all locked content")
                            .font(.custom(mainFont, size: 16))
                            .foregroundColor(Color("textColor"))
                            .fontWeight(.regular)
                    }
//                    HStack {
//                        Image("shop")
//                            .resizable()
//                            .frame(width: 25, height: 25)
//                        Text("Get item shop access")
//                            .font(.custom(mainFont, size: 16))
//                            .foregroundColor(Color("textColor"))
//                            .fontWeight(.regular)
//                    }
                    HStack {
                        Image("bullets")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("More coming soon to Pro Access")

                            .font(.custom(mainFont, size: 16))
                            .foregroundColor(Color("textColor"))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                    }//.frame( height: 50, alignment: .center)
                    
                }.frame(width: UIScreen.screenWidth*0.9, alignment: .center)
                Spacer()
                
                if currentOffering != nil {
                    
                    ForEach(currentOffering!.availablePackages) { pkg in
                        Button {
                            showLoading = true
                            Purchases.shared.purchase(package: pkg) { (transition, CustomerInfo, error, userCancelled) in
                                if CustomerInfo?.entitlements.all["pro"]?.isActive == true {
                                    
                                    checkAccess.isSubscriptionActive = true
                                    isPayWallPresented = false
                                    showLoading = false
                                }
                                showLoading = false
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(height: 55)
                                    .foregroundColor(.blue)
                                    .cornerRadius(25)
                                Text("\(pkg.storeProduct.subscriptionPeriod!.periodTitle) for \(pkg.storeProduct.localizedPriceString)")
                                    .font(.custom(mainFont, size: 18))
                                    .foregroundColor(.white)
                                    .fontWeight(.regular)
                            }
                        }
                    }
                }
                
                Spacer()
                Text("These subscriptions help a lot with app maintenance and some of the costs to keep this app online for you. It also helps pay for services provided by other people/organizations. Also, the webistes, servers, and Discord server I have for this app. Your support is much appreciated. Thank you! 🙂")
                    .font(.custom(mainFont, size: 15))
                    .foregroundColor(Color("textColor"))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            
        }
        .padding()
        .onAppear {
            
            Purchases.shared.getOfferings { offerings, error in
                
                if let offer = offerings?.current, error == nil {
                    currentOffering = offer
                }
                
            }
        }
        .fullScreenCover(isPresented: $showLoading, content: {
            loadingView()
        })
        //.frame(width: UIScreen.screenWidth*0.9)
    }
}

struct PayWall_Previews: PreviewProvider {
    static var previews: some View {
        PayWall(isPayWallPresented: .constant(false))
    }
}
