//
//  TabViewThingy.swift
//  Union_Forums
//
//  Created by Adam Long on 4/21/22.
//

import SwiftUI

struct TabViewThingy: View
{
    var body: some View
    {
        TabView
        {
            HomeView()
            .tabItem
            {
                Image(systemName: "house.fill")
                Text("Home")
            }

//            ExploreView()
//            .tabItem
//            {
//                Image(systemName: "magnifyingglass")
//                Text("Explore")
//            }
            
            NewQuestionView()
            .tabItem
            {
                Image(systemName: "plus")
                Text("New Question")
            }
            
            ProfileView(isLoggedIn: .constant(true), loginIsShowed: .constant(false))
            .tabItem
            {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
    }
}



//struct TabViewThingy: App
//{
//
//    var body: some Scene
//    {
//        WindowGroup
//        {
//            TabView
//            {
//                NavigationView
//                {
//                    HomeView()
//                }
//                .tabItem
//                {
//                    Image(systemName: "house.fill")
//                    Text("Home")
//                }
//                NavigationView
//                {
//                    ExploreView()
//                }
//                .tabItem
//                {
//                    Image(systemName: "magnifyingglass")
//                    Text("Explore")
//                }
//            }
//        }
//    }
//}



