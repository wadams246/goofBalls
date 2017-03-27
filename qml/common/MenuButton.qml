import QtQuick 2.0

Rectangle {
    id: button
    // this will be the default size, it is same size as the contained text + some padding
    width: 130
    height: buttonText.height + paddingVertical * 2
    radius: 6
    border.width: 1.5
    border.color: borderColor
    gradient: Gradient {
        GradientStop { position: 0.0; color: lightColor }
        GradientStop { position: 1.0; color: darkColor }
    }

    // access the text of the Text component
    property alias text: buttonText.text

    property int paddingVertical: 2
    property string lightColor: "white"
    property string darkColor: "black"
    property string borderColor: "black"

    // this handler is called when the button is clicked.
    signal clicked

    Text {
        id: buttonText
        anchors.centerIn: parent
        font.family: riffic.name
        font.pixelSize: 18
        color: "white"
        style: Text.Outline
        styleColor: borderColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: button.clicked()
        onPressed: button.opacity = 0.5
        onReleased: button.opacity = 1
    }
}

//darkGray
//#5c5d60
//#1a1a1a
//#141414

//blue
//#5593ff
//#0043df
//#0015c5

//green
//#7aef76
//#00d209
//#009210

//lightBlue
//#a9d8f4
//#4eb4e6
//#228acb

//orange
//#ff9b5f
//#e75201
//#b63b00

//pink
//#ff84fb
//#e501e4
//#ac00ab

//red
//#ff7db2
//#f50030
//#a5002e

//aqua
//#c3fdff
//#48fff8
//#00ddd6

//yellow
//#fff410
//#f7991e
//#a86800
