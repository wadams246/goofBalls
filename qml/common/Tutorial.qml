import VPlay 2.0
import QtQuick 2.0

Item {
    id: tutorial

    width: container.width
    height: container.height

    property alias tutText: tutText.text

    Rectangle {
        id: container
        width: tutText.width + 5
        height: tutText.height + 5
        radius: 6
        border.width: 1.5
        border.color: "#a86800"
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#fff410" }
            GradientStop { position: 1.0; color: "#f7991e" }
        }

        Text {
            id: tutText
            anchors.centerIn: parent
            text: ""
            horizontalAlignment: Text.AlignHCenter
            font.family: riffic.name
            font.pixelSize: 14
            color: "#ffffff"
            style: Text.Outline
            styleColor: "#a86800"
        }
    }

}
