import VPlay 2.0
import QtQuick 2.0
import "../../common"

Ball {
    id: shielderBall

    baseHp: 325
    baseXp: 450
    baseBouncePoints: 15
    baseKillPoints: 550
    startBounce: -280
    tapBounce: -175
    baseDmgPoints: 20
    gScale: 1
    lScale: 0
    ballPic: "brownBall"
    cat: Circle.Category5

    property int haste: Math.floor(((player.level - 8) / 2));
    property int coolDownTime: 2
    property int shieldPower: 50 + Math.ceil((player.level / 25) * 50);
    property bool coolDown: true

    CircleCollider {
        id: shieldRange
        radius: parent.width
        x: -radius / 2
        y: -radius / 2

        categories: Circle.Category3
        collidesWith: Circle.Category1 | Circle.Category4
        collisionTestingOnlyMode: true
        fixture.onContactChanged: {
            var collidedEntity = other.getBody().target
            if(!coolDown && collidedEntity.entityType === "ball") {
                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../ShieldBolt.qml"), {"ball": shielderBall, "entity": collidedEntity});
                collidedEntity.shield(shieldPower);
                resetCD();

            }
        }
    }

    Rectangle {
        id: rangeIndicator
        width: shielderBall.width * 2
        height: shielderBall.width * 2
        radius: width / 2
        x: shieldRange.x
        y: shieldRange.y
        color: "white"
        opacity: .1

    }

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

//    Text {
//        anchors.centerIn: parent
//        font.pixelSize: 8
//        color: "black"
//        text: coolDownTime
//    }

    Timer {
        interval: 1000
        repeat: true
        running: coolDownTime > 0
        onTriggered: {
            coolDownTime--
            if(coolDownTime === 0) {
                coolDown = false
            }
        }
    }

    function resetCD() {
        cdBack.opacity = cdBar.opacity = 1;
        cdBar.width = spriteWidth;
        coolDownTime = 5;
        coolDown = true;
        cdAnimation.stop();
        cdAnimation.start();
    }
}


