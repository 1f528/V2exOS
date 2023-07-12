//
//  HomeView.swift
//  V2exOSiOS
//
//  Created by isaced on 2023/2/10.
//

//import PagerTabStripView
import SwiftUI
import V2exAPI


struct HomeView: View{
    @EnvironmentObject private var currentUser: CurrentUserStore
    var body: some View {
        NavigationStack{
            List {
                Section(header: Text("Home")) {
                    NavigationLink(destination: TopicListView(nodeName: NodeNameHot)) {
                        Label("最热", systemImage: "chart.line.uptrend.xyaxis")
                    }
                    NavigationLink(destination: TopicListView(nodeName: NodeNameAll)) {
                        Label("最新", systemImage: "clock")
                    }
                }
                
                Section(header: Text("账户")) {
                    NavigationLink(destination: ProfileView()) {
                        Label((currentUser.accessToken != nil) ? "个人信息" : "登录", systemImage: "person.crop.circle")
                    }.tag("profile")
                    //NavigationLink(destination: InboxListView()) {
                    //    Label("消息", systemImage: "envelope")
                    //}
                    .tag("inbox")
                    .disabled(currentUser.accessToken == nil)
                }
                
                Section(header: Text("所有节点")) {
                    NavigationLink {
                        NodeListView()
                    } label: {
                        Label("所有节点", systemImage: "server.rack")
                    }
                }
            }
            .navigationTitle("V2exOS")
        }
    }

    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
