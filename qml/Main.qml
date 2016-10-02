import VPlay 2.0
import QtQuick 2.0
import "./scenes"
import "./entities"

GameWindow {
    id: window
    screenWidth: 640
    screenHeight: 960

    // You get free licenseKeys from http://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    licenseKey: "CDCB35B379500682D6D50A7405DCDE69A575FC63F31E59B2120D203AA6A3433B12ED2E6BD1F28AA8E98C910CBB00423DF01080E9C1858012DD7DE7C3F2FA738650D0F4F05D9C4C78351C7252F17B9478C4A59723588AAC170674C73B5E726B51CBCACBF9F0DA30785B0B312C8CCDE8A9E3ABAB82EEE6A2CC3BAFD5E114647C3AD41CB303AE743D1609EB03D73BC667B7F99E4787376200C8709132C5258D2B89AF24429AE3461A7BF7EC7811D23AC21FD55E02F79729582F48E2203CB6C0FF96C6FD9721B79CE071127FE66883F95A4C1692B46907B6E65AC7F7FADFFD1F0C58DE6D683A6D3755C6CA9DEB39F62D2BFB96A06A448DBD329E0B65C0FD589CB1943CE1A3E280D1CDFFA3C8FDA388425F434F8821953B99532531E723EF2C824C87"

    // create and remove entities at runtime
    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }



    // menu scene
    MenuScene {
        id: menuScene
        // listen to the button signals of the scene and change the state according to it
        onPlayPressed: {
            gameScene.resetBalls()
            window.state = "game"
        }
        onOptionsPressed: window.state = "options"
        onScoresPressed: window.state = "scores"
        onCreditsPressed: window.state = "credits"
        onExitPressed: window.state = "exitConfirm"

        // the menu scene is our start scene, so if back is pressed there we ask the user if he wants to quit the application
        onBackButtonPressed: {
            nativeUtils.displayMessageBox(qsTr("Really quit the game?"), "", 2);
        }
        // listen to the return value of the MessageBox
//        Connections {
//            target: nativeUtils
//            onMessageBoxFinished: {
//                // only quit, if the activeScene is menuScene - the messageBox might also get opened from other scenes in your code
//                if(accepted && window.activeScene === menuScene)
//                    Qt.quit()
//            }
//        }
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
            system.pauseGameForObject(gameScene)
            window.state = "subMenu"
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

    SubMenuScene {
        id: subMenuScene
        onResumePressed: {
            system.resumeGameForObject(gameScene)
            window.state = "game"
        }
        onOptionsPressed: window.state = "subOptions"
        onMainMenuPressed: window.state ="confirm"
    }
    // scene for selecting levels
    OptionsScene {
        id: optionsScene
        onBackButtonPressed: {
            if(window.state === "options") {
                window.state = "menu"
            } else {
                window.state = "subMenu"
            }
        }
    }

    GameOverScene {
        id: gameOverScene
        onPlayPressed: {
            gameScene.resetBalls()
            window.state = "game"
        }
        onMainMenuPressed: window.state = "menu"
        onQuitPressed: window.state = "gameOverExitConfirm"
    }

    ConfirmScene {
        id: menuConfirm
        text: "Really exit to main menu?"
        onConfirmPressed: {
            system.resumeGameForObject(gameScene)
            window.state = "menu"
        }
        onCancelPressed: window.state = "subMenu"
    }

    ConfirmScene {
        id: exitConfirm
        text: "Really exit to exit game?"
        onConfirmPressed: Qt.quit()
        onCancelPressed: window.state = "menu"
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
        },
        State {
            name: "options"
            PropertyChanges {target: optionsScene; opacity: 1}
            PropertyChanges {target: window; activeScene: optionsScene}
        },
        State {
            name: "credits"
            PropertyChanges {target: creditsScene; opacity: 1}
            PropertyChanges {target: window; activeScene: creditsScene}
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
            name: "subMenu"
            PropertyChanges {target: gameScene; opacity: 1; enabled: false}
            PropertyChanges {target: subMenuScene; opacity: 1}
            PropertyChanges {target: window; activeScene: subMenuScene}
        },
        State {
            name: "subOptions"
            PropertyChanges {target: gameScene; opacity: 1; enabled: false}
            PropertyChanges {target: optionsScene; opacity: 1}
            PropertyChanges {target: window; activeScene: optionsScene}
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
