//
//  pathfinderSayings.swift
//  apexhelperV2
//
//  Created by Ian Spresney on 9/27/22.
//

import SwiftUI

struct pathfinderSayings: View {
    
    var sayings = [
        "I cannot wait to win this match, friend!",
        "The championship is ours!",
        "Time to win, and stay alive!",
        "Good luck. Have fun. Don't die! ",
        "I accept the challenge!",
        "Let's have fun, friend!",
        "This is going to be fun.",
        "We will defeat all of our enemies!",
        "Ready to go.",
        "Powered up and ready to go.",
        "I am ready. I hope you are too!",
        "This is my favorite part!",
        "Ready and excited.",
        "I was created for this! ..I think.",
        "I think we're going to do great, friend!",
        "Excellent. Time to destroy more opponents.",
        "Come on friend, time to win!",
        "Grapple: locked and loaded.",
        "I just polished my grapple.",
        "A match a day keeps the doctor away! Just kidding, I'm made of metal.",
        "Today smells like victory! I love pretending to smell. Sniff sniff!"
    ]
    
    var body: some View {
        HStack {
            Image("pathfinderPng")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50,height: 100)
            Text(sayings.randomElement()!)
                .fontWeight(.regular)
                .foregroundColor(Color("textColor"))
                .multilineTextAlignment(.leading)
                .font(.custom(mainFont, size: 18))
                .frame( alignment: .leading)
            
        }.frame(width: UIScreen.screenWidth*0.95, alignment: .topLeading)
    }
}

struct pathfinderSayings_Previews: PreviewProvider {
    static var previews: some View {
        pathfinderSayings()
    }
}
