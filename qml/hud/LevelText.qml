import QtQuick 2.0

Rectangle {
    id: levelArea

    width: 30
    height: 26

    radius: 6
    border.color: "#a5002e"
    border.width: 1.5
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#ff7db2" }
        GradientStop { position: 1.0; color: "#f50030" }
    }

    Text {
        anchors.centerIn: levelArea
        color: "white"
        style: Text.Outline
        styleColor: "#a5002e"
        font.pixelSize: 20
        font.family: riffic.name
        text: player.level
    }
}

