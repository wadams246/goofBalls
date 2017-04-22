import VPlay 2.0
import QtQuick 2.0
import "../../common"

Ball {
    id: splitBall

    baseHp: 300
    baseXp: 500
    baseBouncePoints: 15
    baseKillPoints: 600
    startBounce: -350
    tapBounce: -300
    baseDmgPoints: 50
    gScale: 1
    lScale: 0
    ballPic: "pinkBall"

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
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("./SplitBall2.qml"), {"startLeftRight": -100,
                                                            "startX": x + width / 2,
                                                            "startY": y + height,
                                                            "spriteWidth": 45,
                                                            "spriteHeight":45
                                                        });
        entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("./SplitBall2.qml"), {"startLeftRight": 100,
                                                            "startX": x + width / 2,
                                                            "startY": y + height,
                                                            "spriteWidth": 45,
                                                            "spriteHeight": 45
                                                        });
    }
}

