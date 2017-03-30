import VPlay 2.0
import QtQuick 2.0
import "scenes"
import "entities"
import "common"

    GameWindow {
        id: window
        screenWidth: 640
        screenHeight: 960

        // You get free licenseKeys from http://v-play.net/licenseKey
        // With a licenseKey you can:
        //  * Publish your games & apps for the app stores
        //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
        //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
        licenseKey: ""

        // create and remove entities at runtime
        EntityManager {
            id: entityManager
            entityContainer: gameScene
        }

        // global music and sound management
        AudioManager {
          id: audioManager
        }

        // custom font
        FontLoader {
            id: riffic
            source: "../assets/RifficFree-Bold.ttf"
        }

        // menu scene
        MenuScene {
            id: menuScene
            // listen to the button signals of the scene and change the state according to it
            onPlayPressed: {
                system.resumeGameForObject(gameScene);
                countDownScene.newGame = true;
                gameScene.resetBalls();
                gameScene.clearText();
                countDownScene.resetCount();
                window.state = "countDown";
            }
            onOptionsPressed: window.state = "options"
            onScoresPressed: window.state = "scores"
            onHowToPressed: window.state = "howTo"
            onCreditsPressed: window.state = "credits"
            onExitPressed: window.state = "exitConfirm"

            // the menu scene is our start scene, so if back is pressed there we ask the user if he wants to quit the application
            onBackButtonPressed: window.state = "exitConfirm"
        }


        // credits scene
        CreditsScene {
            id: creditsScene
            onBackButtonPressed: window.state = "menu"
        }

        // game scene to play a level
        GameScene {
            id: gameScene
            onBackButtonPressed: {
                system.pauseGameForObject(gameScene);
                window.state = "subMenu";
            }
        }

        CountDownScene {
            id: countDownScene
            onStartGame: {
                system.resumeGameForObject(gameScene);
                window.state = "game";
                gameScene.startGame();
                entityManager.createEntityFromUrl(Qt.resolvedUrl("entities/Balls/GreenBall.qml"));
                countDownScene.started = true;
            }
            onResumeGame: {
                system.resumeGameForObject(gameScene);
                window.state = "game"
                gameScene.resumeGame();
            }
            onBackButtonPressed: {
                system.pauseGameForObject(gameScene);
                window.state = "subMenu";
            }
        }

        BallGenerator {
            id: ballGen
        }

        Player {
            id: player
        }

        // show high scores
        ScoresScene {
            id: scoresScene
            onBackButtonPressed: window.state = "menu"
        }

        HowToScene {
            id: howToScene
            onBackButtonPressed: window.state = "menu"
        }

        SubMenuScene {
            id: subMenuScene
            onResumePressed: {
                gameScene.clearText();
                countDownScene.newGame = false;
                countDownScene.resetCount();
                window.state = "countDown";
            }
            onMainMenuPressed: window.state ="confirm"
        }

        GameOverScene {
            id: gameOverScene
            onPlayPressed: {
                countDownScene.newGame = true;
                gameScene.resetBalls();
                countDownScene.resetCount();
                window.state = "countDown";
            }
            onMainMenuPressed: window.state = "menu"
            onQuitPressed: window.state = "gameOverExitConfirm"
        }

        ConfirmScene {
            id: menuConfirm
            text: "Really exit to main menu?"
            onConfirmPressed: {
                window.state = "menu"
            }
            onCancelPressed: window.state = "subMenu"
        }

        ConfirmScene {
            id: exitConfirm
            text: "Really exit game?"
            onConfirmPressed: Qt.quit()
            onCancelPressed: window.state = "menu"
        }

        Timer {
            id: startMusic
            interval: 5000
            onTriggered: audioManager.playMusic("theme")
        }

        // menuScene is our first scene, so set the state to menu initially
        state: "menu"
        activeScene: menuScene

        // state machine, takes care reversing the PropertyChanges when changing the state, like changing the opacity back to 0
        states: [
            State {
                name: "menu"
                PropertyChanges {target: menuScene; opacity: 1}
                PropertyChanges {target: window; activeScene: menuScene}
                StateChangeScript {
                                name: "bgMusicScript"
                                script: startMusic.start();
                            }
            },
            State {
                name: "credits"
                PropertyChanges {target: creditsScene; opacity: 1}
                PropertyChanges {target: window; activeScene: creditsScene}
            },
            State {
                name: "countDown"
                PropertyChanges {target: gameScene; opacity: 1; enabled: false}
                PropertyChanges {target: countDownScene; opacity: 1}
                PropertyChanges {target: window; activeScene: countDownScene}
                StateChangeScript {script: audioManager.stopMusic("theme");}
            },
            State {
                name: "game"
                PropertyChanges {target: gameScene; opacity: 1}
                PropertyChanges {target: window; activeScene: gameScene}
            },
            State {
                name: "scores"
                PropertyChanges {target: scoresScene; opacity: 1}
                PropertyChanges {target: window; activeScene: scoresScene}
            },
            State {
                name: "howTo"
                PropertyChanges {target: howToScene; opacity: 1}
                PropertyChanges {target: window; activeScene: howToScene}
            },
            State {
                name: "subMenu"
                PropertyChanges {target: gameScene; opacity: 1; enabled: false}
                PropertyChanges {target: subMenuScene; opacity: 1}
                PropertyChanges {target: window; activeScene: subMenuScene}
            },
            State {
                name: "confirm"
                PropertyChanges {target: gameScene; opacity: 1; enabled: false}
                PropertyChanges {target: subMenuScene; opacity: 1}
                PropertyChanges {target: menuConfirm; opacity: 1}
                PropertyChanges {target: window; activeScene: menuConfirm}
            },
            State {
                name: "exitConfirm"
                PropertyChanges {target: menuScene; opacity: 1}
                PropertyChanges {target: exitConfirm; opacity: 1}
                PropertyChanges {target: window; activeScene: exitConfirm}
            },
            State {
                name: "gameOver"
                PropertyChanges {target: gameScene; opacity: 1; enabled: false}
                PropertyChanges {target: gameOverScene;  opacity: 1}
                PropertyChanges {target: window; activeScene: gameOverScene}
            },
            State {
                name: "gameOverExitConfirm"
                PropertyChanges {target: gameScene; opacity: 1}
                PropertyChanges {target: gameOverScene; opacity: 1}
                PropertyChanges {target: exitConfirm; opacity: 1}
                PropertyChanges {target: window; activeScene: exitConfirm}
            }
        ]
    }
