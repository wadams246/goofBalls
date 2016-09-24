import VPlay 2.0
import QtQuick 2.0
import "../"
import "../../scenes"
import "../../common"


Ball {
    id: shieldBall

    baseHp: 200
    baseXp: 325
    baseBouncePoints: 15
    baseKillPoints: 375
    startBounce: -280
    tapBounce: -175
    baseDmgPoints: 15
    gScale: 1
    lScale: 0
    ballPic: "orangeBall"
    cat: Circle.Category1

//    property int coolDownTime: 7 - haste > 2 ? haste : 3;
    property int haste: Math.floor(((player.level - 8) / 2));
    property int coolDownTime: 2;
    property int currentLevel: 1;
    property int shieldPower: 50 + Math.ceil((player.level / 25) * 50);
    property bool coolDown: true;

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
        text: "Shield"
    }

    Timer {
        interval: 1000
        repeat: true
        running: coolDownTime > 0
        onTriggered: {
            coolDownTime--
            if(coolDownTime === 0) {
                coolDown = false;
                shieldBall.shield(shieldPower);
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

