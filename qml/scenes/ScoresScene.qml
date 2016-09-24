import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: scoresScene

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#49a349"
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: scoresScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: scoresScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
    }

    // scores
    Text {
        text: "High Scores"
        color: "white"
        anchors.centerIn: parent
    }
}
