import VPlay 2.0
import QtQuick 2.0
import "../common"
import "../entities"

SceneBase {
    id: gameOverScene

    signal playPressed
    signal mainMenuPressed
    signal quitPressed


    Text {
        id: gameOverText

        anchors {
            horizontalCenter: gameOverScene.horizontalCenter
            bottom: scoreText.top
            bottomMargin: 5
        }

        text: "GAME OVER"
        font.family: riffic.name
        font.pixelSize: 42
        color: "#f50030"
        style: Text.Outline
        styleColor: "#a5002e"
    }

    Text {
        id: scoreText

        anchors {
            horizontalCenter: gameOverScene.horizontalCenter
            bottom: gameMenu.top
            bottomMargin: 20
        }

        text: "YOUR SCORE: " + player.score
        font.family: riffic.name
        font.pixelSize: 18
        color: "white"
        style: Text.Outline
        styleColor: "#0043df"
    }
    //TODO add ranking system

    Column {
        id: gameMenu

        anchors.centerIn: parent
        spacing: 1

        MenuButton {
            text: "PLAY AGAIN"
            lightColor: "#7aef76"
            darkColor: "#00d209"
            borderColor: "#009210"
            onClicked: playPressed()
        }
        MenuButton {
            text: "MAIN MENU"
            lightColor: "#fff410"
            darkColor: "#f7991e"
            borderColor: "#a86800"
            onClicked: mainMenuPressed()
        }
        MenuButton {
            text: "QUIT"
            lightColor: "#ff7db2"
            darkColor: "#f50030"
            borderColor: "#a5002e"
            onClicked: mainMenuPressed()
        }
    }
    VolumeControl {
        id: volControl

        width: noAddsControl.width
        height: noAddsControl.height
        anchors {
            top: gameMenu.bottom
            topMargin: 20
            left: gameMenu.left
        }
    }
    RateLink {
        id: rateLink

        width: noAddsControl.width
        height: noAddsControl.height
        anchors {
            top: gameMenu.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
            verticalCenter: noAddsControl.verticalCenter
        }
    }
    NoAddsControl {
        id: noAddsControl

        anchors {
            top: gameMenu.bottom
            topMargin: 20
            right: gameMenu.right
        }
    }
}
