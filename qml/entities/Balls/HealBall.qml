import VPlay 2.0
import QtQuick 2.0
import "../"
import "../../scenes"
import "../../common"


Ball {
    id: healBall

    baseHp: 100
    baseXp: 275
    baseBouncePoints: 10
    baseKillPoints: 350
    startBounce: -350
    tapBounce: -300
    baseDmgPoints: 20
    gScale: 1
    lScale: 0
    ballPic: "aquaBall"
    cat: Circle.Category1

    property int coolDownTime: 2
    property int currentLevel: 1
    property int healPower: 30 + Math.ceil((player.level / 25) * 50);
    property bool coolDown: true

    CoolDownBar {
        id: coolDownBar
        absoluteX: 0
        absoluteY: -coolDownBar.height
        width: healBall.width
        height: 5
        coolDownTime: coolDownTime
        visible: true
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
                coolDown = true;
                coolDownTime = 7;
                coolDownBar.resetCD();
            }
        }
    }
}

