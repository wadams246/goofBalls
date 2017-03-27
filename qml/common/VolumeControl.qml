import QtQuick 2.0

Rectangle {
    id: volumeControl

    width: volPic.width
    height: volPic.height

//    color: "transparent"
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#ff9b5f" }
        GradientStop { position: 1.0; color: "#e75201" }
    }
    border.width: 1
    border.color: "#b63b00"
    radius: 6

    property bool sound: true

    Rectangle {
        id: volPic

        width: speakerPic.width + soundWaves.width
        height: speakerPic.height

        anchors.centerIn: parent
        color: "transparent"

        property bool sound: true

        Image {
            id: speakerPic

            width: Math.round(implicitWidth * .13)
            height: Math.round(implicitHeight * .15)

            source: "../../assets/img/sound/speaker.png"
        }

        Image {
            id: soundWaves

            width: Math.round(implicitWidth * .13)
            height: Math.round(implicitHeight * .15)

            anchors.left: speakerPic.right
            anchors.leftMargin: 2
            anchors.verticalCenter: speakerPic.verticalCenter
            source: "../../assets/img/sound/soundWaves.png"
            opacity: 1
        }

        MouseArea {
            anchors.fill: parent

            onPressed: {
                mute();
            }
        }
    }

    function mute() {
        sound = !sound;
        soundWaves.opacity = sound ? 1 : 0;
        audioManager.muteSounds();
    }
}
