//
//  SearchView.swift
//  V2exOSiOS
//
//  Created by Lehan Yang on 7/13/23.
//

import SwiftUI
import V2exAPI

struct SearchView: View {
    //@EnvironmentObject private var currentUser: CurrentUserStore
    @Environment(\.openURL) private var openURL
    
    @State var nodeList: [V2Node]?
    @State var isLoading = true
    
    @State var searchText: String = ""
    @State private var selectionNodeName: String? = nil
    
    var nodeListFilter: [V2Node]? {
        print(searchText.lowercased())
        if let filtred = nodeList?.filter({ $0.title!.lowercased().contains(searchText.lowercased()) }) {
            return (filtred.count > 6) ? filtred.prefix(upTo: 6).shuffled() : filtred
        }
        return nil
    }

    var body: some View {
        let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        NavigationStack {
            List {
                if let nodeListFilter, nodeListFilter.count > 0 {
                    Section(header: Text("节点")) {
                            ForEach(nodeListFilter) { node in
                                NavigationLink(destination:TopicListView(nodeName: node.name)) {
                                    Text("\(node.title!)")
                                }
                            }
                    }
                }
                Section(header: Text("谷歌搜索")) {
                    Link(destination: URL(string: "https://www.google.com/search?q=site:v2ex.com/t%20\(query!)")!) {
                        Text("谷歌搜索 \(searchText)")
                    }
                }
            }
        }
        .searchable(text: $searchText, placement: .toolbar, prompt: Text("搜索"))
        .onFirstAppear {
                    Task {
                        self.nodeList = try await v2ex.nodesList()
                        self.isLoading = false
                    }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
