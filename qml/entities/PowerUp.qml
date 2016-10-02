import VPlay 2.0
import QtQuick 2.0
import "../scenes"
import "../entities"

EntityBase {
    id: powerUp

    x: utils.generateRandomValueBetween(50, gameScene.width - 50);
    y: utils.generateRandomValueBetween(100, gameScene.height - 100);

    property int healPower: 25 + (25 * (player.level * .1))
    property int powerPower: 25 + (25 * (player.level * .1))
    property int xpPower: 2
    property int activeTime: 3

    Rectangle {
        id: powerUpSprite

        width: 25
        height: 25
        color: "yellow"
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

    Timer {
        interval: 1000
        running: activeTime > 0
        onTriggered:  {
            activeTime--;
            if(activeTime < 1) {
                powerUp.removeEntity();
            }
        }
    }

    function pickPowerUp() {
        var rand = utils.generateRandomValueBetween(0, 101);

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
