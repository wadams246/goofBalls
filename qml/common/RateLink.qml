import QtQuick 2.0

Rectangle {
    id: rateLink

    width: rateText.width + 5
    height: rateText.height + 5

//    color: "transparent"
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#fff410" }
        GradientStop { position: 1.0; color: "#f7991e" }
    }
    border.width: 2
    border.color: "#a86800"
    radius: 6
    anchors {
        top: buttonColumn.bottom
        topMargin: 20
        horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: rateText

        anchors.centerIn: parent
        font.family: riffic.name
        font.pixelSize: 10
        color: "white"
        text: "RATE \nAPP"
        horizontalAlignment: Text.AlignHCenter

    }

    MouseArea {
        anchors.fill: parent

        onPressed: {
            rateText.color = "black"
        }
    }
}
