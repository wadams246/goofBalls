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
    licenseKey: "215ED2B98945E390964E71984DFDAAD502E3A14074D852AE9B179AC81A56EC752E04AC48B28DBD8B17686C89FE9A66DDDB14EB72D0E5AC8A0D713C9A92575593F6E4C293A4B1B4EFC97AD04A31F62BD93FBDA091EDC89A2B72B625FA1115CF53F173FEBC6E6572A8E219E14DDA29719703A2F137A7CB06720F91F448D02C21FB66A5AB2B430243A2EA4D5779AA403B735F34F2F422E3014E8B7863D633CC447C6A300CC93CE7EE2CE6BF0E023EC4EE795FDF6F815968FA2450DCD87F4C96D83BB55C62D96101C5EDF2EAF7E73D85C3CCADD1BC16C2F4379E66BB3F3FDEED72FFBB42FC64BB6DDF4CFFA7BB67E8D9F4DDF9428D39FAC1B5BD61D99B1235FD78E11A54F5B036A802E58D50FBB49DEF623C97373C4B06A3579830737E435BF3DBF5"

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
