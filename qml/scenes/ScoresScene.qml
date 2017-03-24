import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: scoresScene

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#0043df"
    }

    // back button
    MenuButton {
        text: "Back"

        anchors {
            right: parent.gameWindowAnchorItem.right
            rightMargin: 10
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
        id: gameDevCred

        anchors.centerIn: parent

        title: "COMMING SOON!!"
        name: ""
    }
}
