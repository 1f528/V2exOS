//
//  NodeListView.swift
//  V2exOSiOS
//
//  Created by isaced on 2023/2/11.
//

import SwiftUI
import V2exAPI

struct NodeListView: View {
    @EnvironmentObject private var currentUser: CurrentUserStore
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
        NavigationStack {
            List {
                Section(header: Text("推荐")) {
                    NavigationLink(destination: TopicListView(nodeName: NodeNameHot)) {
                        Label("最热", systemImage: "chart.line.uptrend.xyaxis")
                    }
                    NavigationLink(destination: TopicListView(nodeName: NodeNameAll)) {
                        Label("最新", systemImage: "clock")
                    }
                }
                                
                Section(header: Text("所有节点")) {
                    if isLoading {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else {
                        if let nodeList = nodeList {
                            ForEach(nodeList) { node in
                                NavigationLink(destination: TopicListView(nodeName: node.name)) {
                                    Text(node.title ?? "")
                                }
                            }
                        }
                    }
                }
            }
            .onFirstAppear {
                Task {
                    self.nodeList = try await v2ex.nodesList()
                    self.isLoading = false
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("节点")
        }
    }
}


struct NodeListView_Previews: PreviewProvider {
    static var previews: some View {
        NodeListView()
    }
}
