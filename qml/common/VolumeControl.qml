import QtQuick 2.0

Rectangle {
    id: volumeControl

    width: volPic.width
    height: volPic.height

//    color: "transparent"
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#ff84fb" }
        GradientStop { position: 1.0; color: "#e501e4" }
    }
    border.width: 2
    border.color: "#ac00ab"
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

            width: Math.round(151 * .08)
            height: Math.round(220 * .08)

            source: "../../assets/img/hud/speaker.png"
        }

        Image {
            id: soundWaves

            width: Math.round(92 * .08)
            height: Math.round(206 * .08)

            anchors.left: speakerPic.right
            anchors.leftMargin: 2
            anchors.verticalCenter: speakerPic.verticalCenter
            source: "../../assets/img/hud/soundWaves.png"
            opacity: 1
        }

        Image {
            id: noSound

            width: Math.round(134 * .07)
            height: Math.round(134 * .07)

            anchors.left: speakerPic.right
            anchors.leftMargin: 2
            anchors.verticalCenter: speakerPic.verticalCenter
            source: "../../assets/img/hud/noSound.png"
            opacity: 0
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
        if(sound) {
            noSound.opacity = 0;
            soundWaves.opacity = 1;
        } else {
            noSound.opacity = 1;
            soundWaves.opacity = 0;
        }
        console.log('mute ', sound);
    }
}
