import Foundation

@available(macOS 10.13, *)
struct ShellCommand {

    enum Error: Swift.Error {
        case processRunFailure(String)
        case standardOutputInvalidation
    }

    let command: String
    let arguments: [String]

    init(command: String, arguments: [String] = []) {
        self.command = command
        self.arguments = arguments
    }

    private func createProcess(command: String, arguments: [String]) -> Process {
        let process = Process()
        guard let commandPath: String = findFullPath(for: command) else {
            fatalError()
        }
        process.executableURL = URL(fileURLWithPath: commandPath)
        process.arguments = arguments
        return process
    }

    func findFullPath(for command: String) -> String? {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/which")
        process.arguments = [command]
        let pipe = Pipe()
        process.standardOutput = pipe

        try! process.run()
        process.waitUntilExit()

        guard let result: String = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) else {
            fatalError()
        }
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func connectToPipe(process: Process) -> Pipe {
        let pipe = Pipe()
        process.standardOutput = pipe
        return pipe
    }

    func run() -> Result<String, Swift.Error> {

        let process = createProcess(command: command, arguments: arguments)
        let pipe = connectToPipe(process: process)

        do {
            try process.run()
            process.waitUntilExit()
            guard let output: String = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) else {
                return Result.failure(Error.standardOutputInvalidation)
            }
            return Result.success(output.trimmingCharacters(in: .whitespacesAndNewlines))
        } catch {
            print(error)
            return Result.failure(Error.processRunFailure(error.localizedDescription))
        }

    }
}
