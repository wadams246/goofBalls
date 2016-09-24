import VPlay 2.0
import QtQuick 2.0
import "../"
import "../../scenes"
import "../../common"


Ball {
    id: healBall

    baseHp: 250
    baseXp: 275
    baseBouncePoints: 10
    baseKillPoints: 350
    startBounce: -280
    tapBounce: -175
    baseDmgPoints: 20
    gScale: 1
    lScale: 0
    ballPic: "whiteBall"
    cat: Circle.Category1

    property int coolDownTime: 2
    property int currentLevel: 1
    property int healPower: 50 + Math.ceil((player.level / 25) * 50);
    property bool coolDown: true

    Rectangle {
        id: cdBack
        anchors.bottom: parent.top
        height: 5
        width: spriteWidth
        color: "black"
        opacity: 1
        radius: 1
    }

    Rectangle {
        id: cdBar
        anchors.bottom: parent.top
        height: 5
        width: spriteWidth
        color: "#0099ff"
        opacity: 1
        radius: 1

        NumberAnimation on width {
            id: cdAnimation
            to: 0
            duration: coolDownTime * 1000
            onStopped: cdBar.opacity = cdBack.opacity = 0
        }
    }

    Text {
        anchors.centerIn: parent
        font.pixelSize: 8
        color: "black"
        text: healPower
    }

    Timer {
        interval: 1000
        repeat: true
        running: coolDownTime > 0
        onTriggered: {
            coolDownTime--
            if(coolDownTime === 0) {
                coolDown = false;
                healBall.heal(healPower);
                resetCD();
            }
        }
    }

    function resetCD() {
        coolDown = true;
        coolDownTime = 5;
        cdBack.opacity = cdBar.opacity = 1;
        cdBar.width = spriteWidth;
        cdAnimation.stop();
        cdAnimation.start();

    }
}

