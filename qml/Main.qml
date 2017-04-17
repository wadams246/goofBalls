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
        //licenseKey: "CDCB35B379500682D6D50A7405DCDE69A575FC63F31E59B2120D203AA6A3433B12ED2E6BD1F28AA8E98C910CBB00423DF01080E9C1858012DD7DE7C3F2FA738650D0F4F05D9C4C78351C7252F17B9478C4A59723588AAC170674C73B5E726B51CBCACBF9F0DA30785B0B312C8CCDE8A9E3ABAB82EEE6A2CC3BAFD5E114647C3AD41CB303AE743D1609EB03D73BC667B7F99E4787376200C8709132C5258D2B89AF24429AE3461A7BF7EC7811D23AC21FD55E02F79729582F48E2203CB6C0FF96C6FD9721B79CE071127FE66883F95A4C1692B46907B6E65AC7F7FADFFD1F0C58DE6D683A6D3755C6CA9DEB39F62D2BFB96A06A448DBD329E0B65C0FD589CB1943CE1A3E280D1CDFFA3C8FDA388425F434F8821953B99532531E723EF2C824C87"

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
                if(tutorialScene.skip) {
                system.resumeGameForObject(gameScene);
                countDownScene.newGame = true;
                countDownScene.resetCount();
                } else {
                    window.state = "tutorial";
                }
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

        TutorialScene {
            id: tutorialScene
            onSkipPressed: {
                system.resumeGameForObject(gameScene);
                countDownScene.newGame = true;
                countDownScene.resetCount();
                window.state = "countDown";
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
                name: "tutorial"
                PropertyChanges {target: gameScene; opacity: 1; enabled: false}
                PropertyChanges {target: tutorialScene; opacity: 1}
                PropertyChanges {target: window; activeScene: tutorialScene}
                StateChangeScript {script: audioManager.stopMusic("theme");}
            },
            State {
                name: "countDown"
                PropertyChanges {target: gameScene; opacity: 1; enabled: false}
                PropertyChanges {target: countDownScene; opacity: 1}
                PropertyChanges {target: window; activeScene: countDownScene}
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
