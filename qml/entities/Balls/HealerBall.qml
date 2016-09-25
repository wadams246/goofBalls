import VPlay 2.0
import QtQuick 2.0
import "../../common"

Ball {
    id: healerBall

    baseHp: 300
    baseXp: 400
    baseBouncePoints: 15
    baseKillPoints: 500
    startBounce: -280
    tapBounce: -175
    baseDmgPoints: 25
    gScale: 1
    lScale: 0
    ballPic: "magentaBall"
    cat: Circle.Category4

    property int coolDownTime: 2
    property bool coolDown: true
    property int healPower: 50 + Math.ceil((player.level / 25) * 50);

    CircleCollider {
        id: healRange
        radius: parent.width
        x: -radius / 2
        y: -radius / 2

        categories: Circle.Category3
        collidesWith: Circle.Category1 | Circle.Category5
        collisionTestingOnlyMode: true
        fixture.onContactChanged: {
            var collidedEntity = other.getBody().target
            if(!coolDown && collidedEntity.entityType === "ball") {
                entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../HealBolt.qml"), {"ball": healerBall, "entity": collidedEntity});
                collidedEntity.heal(healPower);
                resetCD();

            }
        }
    }

    Rectangle {
        id: rangeIndicator
        width: healerBall.width * 2
        height: healerBall.width * 2
        radius: width / 2
        x: healRange.x
        y: healRange.y
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


