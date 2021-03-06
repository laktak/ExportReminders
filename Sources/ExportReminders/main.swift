import ArgumentParser

enum Exception: Error {
    case couldNotReadReminders
    case didNotFindList
}

struct RemindersExport: ParsableCommand {
    
    enum Exception: Error {
        case couldNotReadReminders
        case didNotFindList
    }
    
    @Flag
    var includeCompleted: Bool = false
    
    @Option(name: .shortAndLong, help: "The name of the list to export.")
    var listName: String?
    
    func run() throws {
        let source = RemindersSource()
        
        guard let name = listName else {
            // Write CSV Head
            print("list-names")
            print(
                source.getNames().joined(separator: "\n")
            )
            return
        }
        
        // Write CSV Head
        print("title;completed;date")
        for row in try source.getReminders(named: name, includeCompleted: includeCompleted) {
            print(
                row.map(\.description).joined(separator: ";")
            )
        }
        
    }
}

RemindersExport.main()
