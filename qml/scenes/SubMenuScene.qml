import VPlay 2.0
import QtQuick 2.0
import "../common"

// EMPTY SCENE
SceneBase {
    id: subMenuScene

    signal resumePressed
    signal optionsPressed
    signal mainMenuPressed

    Column {

        anchors.centerIn: parent
        spacing: 1
        MenuButton {
            text: "Resume"
            onClicked: resumePressed()
        }
        MenuButton {
            text: "Options"
            onClicked: optionsPressed()
        }
        MenuButton {
            text: "Main Menu"
            onClicked: mainMenuPressed()
        }
    }
}



