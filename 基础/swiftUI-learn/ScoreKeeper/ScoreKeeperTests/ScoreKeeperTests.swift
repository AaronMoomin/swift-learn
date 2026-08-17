//
//  ScoreKeeperTests.swift
//  ScoreKeeperTests
//
//  Created by hcp on 2026/7/29.
//

import Testing
// 您的测试产品与应用程序本身是分开的。这意味着您需要导入您的应用程序 ScoreKeeper 来进行测试
@testable import ScoreKeeper

struct ScoreKeeperTests {

    @Test("Reset player scores", arguments: [0, 10, 20])
    func resetScores(to newValue: Int) async throws {
        var scoreboard = Scoreboard(players: [
            Player(name: "Elisha", score: 0),
            Player(name: "Andre", score: 0),
        ])
        scoreboard.resetScores(to: newValue)
        
        for player in scoreboard.players {
            #expect(player.score == newValue)
        }
    }

    @Test("Highest score wins")
    func highestScoreWins() {
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4),
            ],
            state: .gameOver,
            doesHighestScoreWin: true
        )
        let winners = scoreboard.winners
        #expect(winners == [Player(name: "Andre", score: 4)])
    }
    
    @Test("Lowest score wins")
    func lowestScoreWins() {


    }
}
