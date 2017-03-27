import VPlay 2.0
import QtQuick 2.0

Item {
    id: countDown

    width: 1
    height: 1
    opacity: 1

    property int count: 3

    // text displaying either the countdown or "tap!"
    Text {
        id: countDownText
        anchors.centerIn: parent
        color: "white"
        font.family: riffic.name
        style: Text.Outline
        styleColor: "#0015c5"
        font.pixelSize: 60
        text: count > 0 ? count : ""
    }

    NumberAnimation on opacity {
        id: fadeCountDown
        to: .30
        duration: 1000
    }

    function countDown() {
        fadeCountDown.stop();
        countDown.opacity = 1;
        fadeCountDown.start();
        count--;
    }

}
