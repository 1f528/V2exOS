//
//  TopicDetailView.swift
//  V2exOS
//
//  Created by isaced on 2022/7/24.
//

import MarkdownUI
import SwiftUI
import V2exAPI

struct TopicDetailView: View {
    @EnvironmentObject private var settingsConfig: SettingsConfig
    
    var topic: V2Topic
    
    @State var commentList: [V2Comment]?
    @State var isCommentLoading = true
    
    var body: some View {
        ScrollView {
            Group {
                VStack(alignment: .leading, spacing: 5) {
                    Text(topic.title ?? "")
                        .font(.title)
                        .lineLimit(3)
                        .foregroundColor(.label)
#if os(tvOS)
                        .focusable()
#endif
                    
                    HStack(alignment: .bottom, spacing: 20) {
                        if let authorName = topic.member?.username {
                            HStack(alignment: .bottom, spacing: 5) {
                                Image(systemName: "person.circle")
                                UserName(authorName)
                            }
                        }
                        
                        HStack(alignment: .bottom, spacing: 5) {
                            Image(systemName: "clock")
                            if let created = topic.created {
                                Text(Date(timeIntervalSince1970: TimeInterval(created)).fromNow())
                            }
                        }
#if !os(tvOS)
                        Link(destination: URL(string: "https://www.v2ex.com/t/\(topic.id)")!) {
                            HStack(alignment: .bottom, spacing: 5) {
                                Image(systemName: "safari")
#if !os(iOS)
                                Text("在浏览器中打开")
#endif
                            }
                        }
#endif
                    }
                    .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Divider()
                    
                    Spacer()
                    
                    Markdown(topic.content ?? "")
#if os(macOS)
                        .markdownTheme(
                            Theme()
                                .text {
                                    FontSize(settingsConfig.fontSize)
                                }
                        )
#endif
#if os(tvOS)
.focusable()
#endif
.fixedSize(horizontal: false, vertical: true)
                }
#if os(iOS)
                .listRowSeparator(.hidden)
#endif
                Spacer()
                
                CommentListView(commentCount: topic.replies, commentList: commentList)
                
                if isCommentLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
#if os(iOS)
                    .listRowSeparator(.hidden)
#endif
                }
            }
#if os(iOS)
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
#else
            .padding(10)
#endif
        }
#if os(iOS)
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
#endif
        .onFirstAppear {
            loadComments(page: 1)
        }
    }
    
    func loadComments(page: Int) {
        Task {
            do {
                let res = try await v2ex.repliesAll(topicId: topic.id)
                commentList = res
            } catch {
                print(error)
            }
            
            isCommentLoading = false
        }
    }
}

struct TopicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TopicDetailView(topic: PreviewData.topic,
                        commentList: [
                            PreviewData.comment,
                            PreviewData.comment,
                            PreviewData.comment
                        ])
                        .environmentObject(SettingsConfig.shared)
                        .previewLayout(.fixed(width: 300, height: .infinity))
    }
}
