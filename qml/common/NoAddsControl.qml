import QtQuick 2.0

Rectangle {
    id: noAds

    width: noAddsText.width + 5
    height: noAddsText.height + 5

//    color: "transparent"
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#7aef76" }
        GradientStop { position: 1.0; color: "#00d209" }
    }
    border.width: 1
    border.color: "#009210"
    radius: 6
    anchors {
        top: buttonColumn.bottom
        topMargin: 20
        right: buttonColumn.right
    }

    Text {
        id: noAddsText
        anchors.centerIn: parent

        font.family: riffic.name
        font.pixelSize: 10
        color: "white"
        text: "NO \nADDS"
        style: Text.Outline
        styleColor: parent.border.color
        horizontalAlignment: Text.AlignHCenter

    }

    MouseArea {
        anchors.fill: parent

        onPressed:  {
            noAddsText.color = "black"
        }
    }
}
