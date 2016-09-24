import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"

SceneBase {
    id: gameOverScene

    signal playPressed
    signal mainMenuPressed
    signal quitPressed

//    Rectangle {
//        anchors.fill: parent.gameWindowAnchorItem
//        color: "#333333"
//    }


    Text {
        id: gameOverText
        text: "Game Over"
        color: "white"
        font.pixelSize: 60
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    Text {
        id: scoreText
        text: "Your Score " + player.score + "\nRankend 1st"
        color: "white"
        font.pixelSize: 18
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: gameOverText.bottom
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: scoreText.bottom
        anchors.topMargin: 50
        spacing: 1

        MenuButton {
            text: "Play Again"
            onClicked: playPressed()
        }
        MenuButton {
            text: "Main Menu"
            onClicked: mainMenuPressed()
        }
        MenuButton {
            text: "Quit"
            onClicked: quitPressed()
        }
    }
}
