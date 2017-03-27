import QtQuick 2.0

Rectangle {
    id: rateLink

    width: rateText.width + 5
    height: rateText.height + 5

//    color: "transparent"
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#5593ff" }
        GradientStop { position: 1.0; color: "#0043df" }
    }
    border.width: 1
    border.color: "#0015c5"
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
        style: Text.Outline
        styleColor: parent.border.color
        horizontalAlignment: Text.AlignHCenter

    }

    MouseArea {
        anchors.fill: parent

        onPressed: {
            rateText.color = "black"
        }
    }
}
