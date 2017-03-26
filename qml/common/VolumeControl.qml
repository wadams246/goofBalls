import VPlay 2.0
import QtQuick 2.0

Item {
    id: volumeControl

    width: speakerPic.width + soundWaves.width
    height: speakerPic.height

    property bool sound: true
    property real scale: .15

    Image {
        id: speakerPic

        width: Math.round(151 * scale)
        height: Math.round(220 * scale)

        source: "../../assets/img/hud/speaker.png"
    }

    Image {
        id: soundWaves

        width: Math.round(92 * scale)
        height: Math.round(206 * scale)

        anchors.left: speakerPic.right
        anchors.leftMargin: 5
        anchors.verticalCenter: speakerPic.verticalCenter
        source: "../../assets/img/hud/soundWaves.png"
        opacity: 1
    }

    Image {
        id: noSound

        width: 134 * scale
        height: 134 * scale

        anchors.left: speakerPic.right
        anchors.leftMargin: 5
        anchors.verticalCenter: speakerPic.verticalCenter
        source: "../../assets/img/hud/noSound.png"
        opacity: 0
    }

    MouseArea {
        anchors.fill: parent

        onPressed: {
            volControl();
        }
    }

    function volControl() {
        sound = !sound;
        if(sound) {
            noSound.opacity = 1;
            soundWaves.opacity = 0;
        } else {
            noSound.opacity = 0;
            soundWaves.opacity = 1;
        }
    }
}
