//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Ariya Coleman on 2/6/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showingAddAssignmentView = false
    var body: some View {
        NavigationView {
            List {
                ForEach (assignmentList.items) {item in
                    HStack {
                        VStack {
                            Text(item.course)
                                .font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    assignmentList.items.remove(atOffsets: indexSet)
                })
            }
            .sheet(isPresented: $showingAddAssignmentView, content: {
                AddAssignmentView(assignmentList : assignmentList)
            })
            .navigationBarTitle("Assignment Notebook", displayMode: .inline)
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: {
                showingAddAssignmentView = true}) {
                    Image(systemName: "plus")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AssignmentItem: Identifiable, Codable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date ()
}

