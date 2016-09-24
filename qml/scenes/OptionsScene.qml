import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: optionsScene

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: optionsScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: optionsScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
    }

    // levels to be selected
    Column {
        anchors.centerIn: parent
        spacing: 1
        MenuButton {
            text: "Sound"
            width: 200
            height: 50
        }
        MenuButton {
            text: "Difficulty"
            width: 200
            height: 50
        }
    }
}
