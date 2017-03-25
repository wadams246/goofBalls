import QtQuick 2.0

Rectangle {
    id: volumeControl

    width: 40
    height: 40

    color: "yellow"

    MouseArea {
        width: parent.width
        height: parent.height

        anchors.centerIn: parent

        onPressed: {
            parent.color = parent.color == "#ffff00" ? "#ffffff" : "#ffff00";
        }
    }
}
