import SwiftUI
import Foundation

struct ContentView: View {
    @State private var matrix = [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
    ]
    
    @State private var isTurnofX = true
    @State private var gameOverMessage = ""
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack {
                HStack{
                    if !gameOverMessage.isEmpty {
                        Text(gameOverMessage)
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.top, 3)
                    } else {
                        Text("TicTacToe")
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(.top, 3)
                    }
                }
                
                Grid(alignment: .leading, horizontalSpacing: 2, verticalSpacing: 2) {
                    ForEach(matrix.indices, id: \.self) { rowIndex in
                        GridRow {
                            ForEach(matrix[rowIndex].indices, id: \.self) { columnIndex in
                                VStack {
                                    if matrix[rowIndex][columnIndex] != 0 {
                                        if matrix[rowIndex][columnIndex] == 2 {
                                            Text("X")
                                                .font(.caption)
                                                .foregroundColor(.red)
                                        } else if matrix[rowIndex][columnIndex] == 3 {
                                            Text("O")
                                                .font(.caption)
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                                .frame(width: 40, height: 40)
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(radius: 2)
                                .onTapGesture {
                                    if matrix[rowIndex][columnIndex] == 0 && gameOverMessage.isEmpty {
                                        matrix[rowIndex][columnIndex] = isTurnofX ? 2 : 3
                                        if checkWin(matrix, player: isTurnofX ? 2 : 3) {
                                            gameOverMessage = isTurnofX ? "X Wins!" : "O Wins!"
                                        } else if checkDraw(matrix) {
                                            gameOverMessage = "It's a Draw!"
                                        } else {
                                            isTurnofX.toggle()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                if !gameOverMessage.isEmpty {
                    Button(action: resetGame) {
                        Text("Restart Game")
                            .padding(5)
                            .font(.caption2)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
    
    func checkWin(_ array: [[Int]], player: Int) -> Bool {
        for row in array {
            if row.allSatisfy({ $0 == player }) {
                return true
            }
        }
        
        for col in 0..<3 {
            if array.allSatisfy({ $0[col] == player }) {
                return true
            }
        }
        
        if array[0][0] == player && array[1][1] == player && array[2][2] == player {
            return true
        }
        if array[0][2] == player && array[1][1] == player && array[2][0] == player {
            return true
        }
        
        return false
    }
    
    func checkDraw(_ array: [[Int]]) -> Bool {
        return array.allSatisfy { row in
            row.allSatisfy { cell in
                cell != 0
            }
        }
    }
    
    func resetGame() {
        matrix = [
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0]
        ]
        isTurnofX = true
        gameOverMessage = ""
       
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

