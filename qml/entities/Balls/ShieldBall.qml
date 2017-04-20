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
    startBounce: -320
    tapBounce: -280
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

    CoolDownBar {
        id: coolDownBar
        absoluteX: 0
        absoluteY: -coolDownBar.height
        width: shieldBall.width
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
                shieldBall.shield(shieldPower);
                coolDown = true;
                coolDownTime = 5;
                coolDownBar.resetCD();
            }
        }
    }
}

