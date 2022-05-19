//
//  ContentView.swift
//  Union_Forums
//
//  Created by Adam Long on 4/21/22.
//

import SwiftUI

struct ContentView: View //rootView
{
    @State private var isLoggedIn: Bool = false//these are opposites
    @State public var loginIsShown: Bool = true//if 1 is false, other is true
    
    var body: some View
    {
        
        if isLoggedIn == false
        {
            NavigationView
            {
                TabViewThingy()
            }
            .sheet(isPresented: $loginIsShown)
            {
                LoginView(loginIsShowed: $loginIsShown, isLoggedIn: $isLoggedIn)
            }
        }else{
            TabViewThingy()
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
