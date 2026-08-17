import SwiftUI

// Identifiable 表示已设定 唯一id
struct Todo: Identifiable, Codable, Equatable {
    let id = UUID()
    let title: String
    var isDone = false
}

struct TodoListView: View {
    @State private var todos: [Todo]
    @State private var showAlert = false
    @State private var newTodoTitle = ""
    
    init() {
        _todos = State(initialValue: Self.loadTodos())
    }
    
    private static func loadTodos() -> [Todo] {
        guard
            let data = UserDefaults.standard.data(forKey: "todos"),
            let todos = try? JSONDecoder().decode([Todo].self, from: data)
        else {
            return [
                Todo(title: "学习 SwiftUI"),
                Todo(title: "完成 TodoList")
            ]
        }
        return todos
    }
    
    private func saveTodos() {
        let data = try? JSONEncoder().encode(todos)
        UserDefaults.standard.set(data, forKey: "todos")
    }
    
    private var completeTodos: [Todo] {
        todos.filter { $0.isDone }
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("输入新任务", text: $newTodoTitle)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal)
                
                Button("添加") {
                    let title = newTodoTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    guard !title.isEmpty else {
                        showAlert = true
                        return
                    }
                    todos.append(Todo(title: title))
                    newTodoTitle = ""
                }
            }
            .padding(.horizontal)
            
            NavigationStack {
                List {
                    Section("Done") {
                        ForEach(completeTodos) { todo in
    //                        需要修改的值才需要用 $todo
                            TodoItemView(title: todo.title)
                        }
                    }
                    
                    Section {
                        // 由于已有Identifiable 所以不用写id: \.self
                        ForEach($todos) { $todo in
                        // 需要修改的值才需要用 $todo
                            TodoItemView(title: todo.title, isDone: $todo.isDone)
                        }
                        .onDelete { index in
                            todos.remove(atOffsets: index)
                        }
                    } header: {
                        Text("Done")
                            .font(.title)
                    } footer: {
                        Text("left slide can delete")
                            .font(.subheadline)
                    }
                }
                .navigationTitle("待办事项 \(completeTodos.count) / \(todos.count)")
            }
            .onChange(of: todos) { _,_ in
                saveTodos()
            }
        }
        .alert("提醒", isPresented: $showAlert) {
            Button("确认", role: .cancel){ }
        } message: {
            Text("输入不能为空")
        }
    }
}

#Preview {
    TodoListView()
}
