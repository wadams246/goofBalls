import VPlay 2.0
import QtQuick 2.0

Item {
    id: credit

    width: 1
    height: title.height + name.height

    property alias title: title.text
    property alias name: name.text

    Text {
        id: title

        anchors.horizontalCenter: credit.horizontalCenter
        color: "white"
        font.pixelSize: 20
        font.family: riffic.name
        style: Text.Outline
        styleColor: "#0015c5"
    }
    Text {
        id: name

        anchors.horizontalCenter: credit.horizontalCenter
        anchors.top: title.bottom
        color: "white"
        font.family: riffic.name
        font.pixelSize: 15
        style: Text.Outline
        styleColor: "#0015c5"
    }

}
