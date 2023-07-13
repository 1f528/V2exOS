//
//  HomeView.swift
//  V2exOSiOS
//
//  Created by isaced on 2023/2/10.
//

//import PagerTabStripView
import SwiftUI

struct HomeView: View{
    var body: some View {
        TabView {
            NodeListView()
                .tabItem {
                    Label("节点", systemImage: "network")
                }
            InboxView()
                .tabItem {
                    Label("消息", systemImage: "envelope")
                }
            AccountView()
                .tabItem {
                    Label("账户", systemImage: "person.crop.circle")
                }
            SearchView()
                .tabItem {
                    Label("搜索", systemImage: "magnifyingglass")
                }
            SettingsView()
                .tabItem {
                    Label("设置", systemImage: "gear")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
