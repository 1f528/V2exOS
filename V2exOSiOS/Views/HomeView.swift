//
//  HomeView.swift
//  V2exOSiOS
//
//  Created by isaced on 2023/2/10.
//

//import PagerTabStripView
import SwiftUI



struct HomeView: View{
    /**struct Item: Hashable, Identifiable{
        let name: String
        let id = UUID()
    }
    
    struct Menu: Identifiable{
        let name: String
        let items: [Item]
        let id = UUID()
    }
    
    private let menu: [Menu] = [
        Menu(name: "top",
             items: [
                Item(name:"最热"),
                Item(name:"全部"),
                Item(name:"分享创造"),
                Item(name:"分享发现"),
                Item(name:"酷工作"),
                Item(name:"问与答"),
             ]),
        Menu(name: "all",
             items: [
                Item(name:"all")
             ]),
        Menu(name: "account",
             items: [
                Item(name: "account"),
                Item(name: "account settings?")
             ]),
        Menu(name: "settings",
             items: [
                Item(name: "settings")
             ])
    ]
    
    @State private var singleSelection: UUID?
    
    var body: some View{
        NavigationStack{
            List(selection: $singleSelection){
                ForEach(menu) { type in
                    Section(header: Text(type.name)){
                        ForEach(type.items) { item in
                            NavigationLink(item.name)
                        }
                        .navigationDestination(for: Item.self){
                            TopicListView()
                        }
                    }
                }
            }
            .navigationTitle("V2exOS")
        }
    }**/
    
    var body: some View {
        NavigationStack{
            List {
                Section(header: Text("Home")) {
                    NavigationLink(destination: TopicListView(nodeName: NodeNameHot)) {
                        Label("最热", systemImage: "flame")
                    }
                    NavigationLink(destination: TopicListView(nodeName: NodeNameAll)) {
                        Label("最新", systemImage: "chart.bar")
                    }
                }
                
                Section(header: Text("账户")) {
                    /**NavigationLink(destination: ProfileView()) {
                        Label((currentUser.accessToken != nil) ? "个人信息" : "登录", systemImage: "person.crop.circle")
                    }.tag("profile")
                    NavigationLink(destination: InboxListView()) {
                        Label("消息", systemImage: "envelope")
                    }
                    .tag("inbox")
                    .disabled(currentUser.accessToken == nil)**/
                }
                
                Section(header: Text("所有节点")) {
                    NavigationLink {
                        NodeListView()
                    } label: {
                        Text("node")
                    }
                }
            }
            //.listStyle(.sidebar)
            /**
            .searchable(text: $searchText, placement: .toolbar, prompt: Text("Google Search")) {
                if let nodeListFilter, nodeListFilter.count > 0 {
                    Text("节点")
                    
                    Divider()
                    
                    ForEach(nodeListFilter) { node in
                        Button("    \(node.title!)") {
                            selectionNodeName = node.name
                            searchText = ""
                            scrollViewReader.scrollTo(node.id)
                        }
                    }
                    
                    Divider()
                }
                
                Button("Google \(searchText)") {
                    let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    openURL(URL(string: "https://www.google.com/search?q=site:v2ex.com/t%20\(query!)")!)
                    searchText = ""
                }
            }**/
            /**.onFirstAppear {
                Task {
                    self.nodeList = try await v2ex.nodesList()
                    self.isLoading = false
                }
            }**/
        }
    }

    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


/**
struct HomeView: View {
    let nodes = [
        ["最热", NodeNameHot],
        ["全部", NodeNameAll],
        ["分享创造", "create"],
        ["分享发现", "share"],
        ["酷工作", "jobs"],
        ["问与答", "qna"],
    ]

    var body: some View {
        NavigationStack {
            PagerTabStripView {
                ForEach(0 ..< nodes.count, id: \.self) { index in
                    let item = nodes[index]
                    let title = item[0]
                    let nodeName = item[1]

                    TopicListView(nodeName: nodeName)
                        .pagerTabItem(tag: index) {
                            TitleNavBarItem(title: title)
                        }
                }

                NodeListView()
                    .pagerTabItem(tag: 9999) {
                        TitleNavBarItem(title: "其他版块")
                    }
            }
            .pagerTabStripViewStyle(.scrollableBarButton(tabItemSpacing: 20))
            .toolbar(.hidden, for: .automatic)
        }
    }
}

struct TitleNavBarItem: View {
    let title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
**/
