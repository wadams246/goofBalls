import VPlay 2.0
import QtQuick 2.0
import "../../common"

Ball {
    id: splitBuffBall

    baseHp: 500
    baseXp: 750
    bouncePoints: 5
    killPoints: 100
    startBounce: -280
    tapBounce: -175
    baseDmgPoints: 65
    gScale: 1
    lScale: 0
    ballPic: "darkGrayBall"
    cat: Circle.Category4

    property int haste: Math.floor(((player.level - 8) / 2));
    property int coolDownTime: 5
    property int healPower: 50 + Math.ceil((player.level / 25) * 50);
    property int shieldPower: 50 + Math.ceil((player.level / 25) * 50);
    property bool coolDown: true

    Rectangle {
        id: rangeIndicator
        width: splitBuffBall.width * 3
        height: splitBuffBall.width * 3
        radius: width / 2
        anchors.centerIn: parent
        color: "white"
        opacity: .1
    }

    CircleCollider {
        id: spellRange
        radius: parent.width * 1.5
        x: rangeIndicator.x
        y: rangeIndicator.y

        categories: Circle.Category3
        collidesWith: Circle.Category1 | Circle.Category5
        collisionTestingOnlyMode: true
        fixture.onContactChanged: {
            var collidedEntity = other.getBody().target
            if(!coolDown && collidedEntity.entityType === "ball") {
                var rand = utils.generateRandomValueBetween(0, 101);
                if(rand > 50) {
                    entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../HealBolt.qml"), {"ball": splitBuffBall, "entity": collidedEntity});
                    collidedEntity.heal(healPower);
                } else {
                    entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../ShieldBolt.qml"), {"ball": splitBuffBall, "entity": collidedEntity});
                    collidedEntity.shield(shieldPower);
                }
                resetCD();
            }
        }
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

    function checkHp () {
        if(hp < 1) {
            killPoints += killPoints * (y / gameScene.height);
            player.score += killPoints;
            calXp(xp);
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../FloatingText.qml"), {
                                                                "x": x + (width / 2),
                                                                "y": y + height,
                                                                "score": killPoints,
                                                                "xp": xp
                                                            });
            audioManager.playSound("pop");
            removeEntity();
            spawnTwo();
        } else {
            audioManager.playSound("bounce");
            moveBall();
        }
    }

    function spawnTwo() {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("./SplitHealBall.qml"), {"startLeftRight": -100,
                                                            "startX": x + width / 2,
                                                            "startY": y + height
                                                        });
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("./SplitShieldBall.qml"), {"startLeftRight": 100,
                                                            "startX": x + width / 2,
                                                            "startY": y + height
                                                        });
    }
}

