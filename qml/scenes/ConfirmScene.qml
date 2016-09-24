import VPlay 2.0
import QtQuick 2.0
import "../common"

// EMPTY SCENE
SceneBase {
    id: confirmScene

    signal confirmPressed
    signal cancelPressed

    property alias text: confirmText.text

    Rectangle{
        id: confirmBox
        width: 250
        height: 75
        color: "grey"
        radius: 2
        anchors.centerIn: parent

        Text {
            id: confirmText
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
        }

        Row {

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            spacing: 1

            MenuButton {
                text: "Cancel"
                width: 100
                onClicked: cancelPressed()
            }
            MenuButton {
                text: "Confirm"
                width: 100
                onClicked: confirmPressed()
            }
        }
    }
}

