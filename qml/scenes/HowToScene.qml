import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: instructionScene

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#0043df"
    }

    // back button
    MenuButton {
        text: "Back"

        anchors {
            left: parent.gameWindowAnchorItem.left
            leftMargin: 10
            top: parent.gameWindowAnchorItem.top
            topMargin: 10
        }
        width: 80
        lightColor: "#ff7db2"
        darkColor: "#f50030"
        borderColor: "#a5002e"
        onClicked: backButtonPressed()
    }
    Credit {
        id: instructions

        anchors.centerIn: parent

        title: "Keep the balls in the \nmiddle of the screen. \nIf the balls drop off \nthe bottom of the screen \nyou will take damage \nbased on the ball that \nyou dropped. If you \nhit the balls too high \nthey will regain health. \nThe game will go on for as \nlong as you do."
        name: ""
    }
}
