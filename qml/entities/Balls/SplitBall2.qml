import VPlay 2.0
import QtQuick 2.0
import "../../common"

Ball {
    id: splitBall2

    baseHp: 225
    baseXp: 500
    baseBouncePoints: 25
    baseKillPoints: 1000
    startBounce: -280
    tapBounce: -300
    baseDmgPoints: 25
    gScale: 1
    lScale: 1
    ballPic: "pinkBall"

    property int splitDirection: 0

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
            removeEntity()
            spawnTwo();
        } else {
            audioManager.playSound("bounce");
            moveBall();
        }
    }

    function spawnTwo() {
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("./SplitBall3.qml"), {
                                                            "startLeftRight": -100,
                                                            "startX": x + width / 2,
                                                            "startY": y + height,
                                                            "spriteWidth": 38,
                                                            "spriteHeight":38
                                                        });
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("./SplitBall3.qml"), {
                                                            "startLeftRight": 100,
                                                            "startX": x + width / 2,
                                                            "startY": y + height,
                                                            "spriteWidth": 38,
                                                            "spriteHeight": 38
                                                        });
    }
}

