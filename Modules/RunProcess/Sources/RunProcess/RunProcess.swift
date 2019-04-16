import Foundation

@available(macOS 10.13, *)
struct RunProcess {
    let command: String
    let arguments: [String]

    init?(command: String, arguments: [String]) {
        self.command = command
        self.arguments = arguments
    }

    private func createProcess(command: String, arguments: [String]) -> Process {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin").appendingPathComponent(command)
        process.arguments = arguments
        return process
    }

    private func connectToPipe(process: Process) -> Pipe {
        let pipe = Pipe()
        process.standardOutput = pipe
        return pipe
    }

    func run(_ completion: (String?) -> Void) {

        let process = createProcess(command: command, arguments: arguments)
        let pipe = connectToPipe(process: process)

        do {
            try process.run()
            process.waitUntilExit()
            completion(String(data: pipe.fileHandleForWriting.readDataToEndOfFile(), encoding: .utf8))
        } catch {
            fatalError(error.localizedDescription)
        }

    }
}
