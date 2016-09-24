import VPlay 2.0
import QtQuick 2.0
import "../scenes"
import "../entities"

EntityBase {
    id: powerUp

    property int healPower: 25 + (25 * (player.level * .1))
    property int powerPower: 25 + (25 * (player.level * .1))
    property int xpPower: 2
    property int startX: -50
    property int startY: utils.generateRandomValueBetween(100, gameScene.height - 100)

    Rectangle {
        id: powerUpSprite

        width: 25
        height: 25
        x: -50
        y: gameScene.height / 2
        color: "yellow"

        NumberAnimation on x {
            id: spriteAnimation

            to: gameScene.width + powerUpSprite.width
            duration: 1250
        }
    }

    MouseArea {
        id: powerUpMouseArea

        anchors.centerIn: powerUpSprite
        width: powerUpSprite.width + 30
        height: powerUpSprite.height + 30
        onPressed: {
            pickPowerUp();
            powerUp.removeEntity();
        }
    }

    Component.onCompleted: {
        x: startX
        y: startY
    }

    function pickPowerUp() {
        rand = utils.generateRandomValueBetween(0, 101);

        if(rand > 34) {
            healPoewrUp();
        } else if(rand > 67) {
            powerPowerUp();
        } else {
            xpPowerUp();
        }
    }

    function healPowerUp() {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/FloatingPowerUpText.qml"), {
                                                            "x": x + (width / 2),
                                                            "y": y + height,
                                                            "text": "+ " + healPower + " HP"
                                                        });
        player.heal(healPower);
    }

    function powerPowerUp() {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/FloatingPowerUpText.qml"), {
                                                            "x": x + (width / 2),
                                                            "y": y + height,
                                                            "text": "+ " + powerPower + " Power"
                                                        });
//        player.heal(healPower);
    }

    function xpPowerUp() {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/FloatingPowerUpText.qml"), {
                                                            "x": x + (width / 2),
                                                            "y": y + height,
                                                            "text": "Double XP"
                                                        });
//        player.heal(healPower);
    }
}
