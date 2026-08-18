

protocol FileSystemComponent {
    var name: String { get }
    func display()
}

class File: FileSystemComponent {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func display() {
        print("File: \(name)")
    }
}

class Folder: FileSystemComponent {
    var name: String
    private var children: [FileSystemComponent] = []
    
    init(name: String) {
        self.name = name
    }
    
    func add(_ component: FileSystemComponent) {
        children.append(component)
    }
    
    func remove(_ component: FileSystemComponent) {
        children.removeAll{ $0.name == component.name }
    }
    
    func display() {
        print("Folder: \(name)")
        for child in children {
            child.display()
        }
    }
}

let rootFolder = Folder(name: "Root")
let documentsFolder = Folder(name: "Documents")
let photosFolder = Folder(name: "Photos")

let file1 = File(name: "file1.txt")
let file2 = File(name: "file2.txt")
let photo1 = File(name: "photo1.jpg")

rootFolder.add(documentsFolder)
rootFolder.add(photosFolder)

documentsFolder.add(file1)
documentsFolder.add(file2)
photosFolder.add(photo1)

rootFolder.display()
