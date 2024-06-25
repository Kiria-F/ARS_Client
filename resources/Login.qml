import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: root
    property bool expanded: false
    width: platform.width
    height: platform.height

    Connections {
        target: api

        function onAuthLoginResponse(success, value) {
            if (success) {
                // loginButton.text = 'Success'
                // light.color = Global.successColor
                // let token = value
                // let tokenLen = token.length;
                // for (let i = 7; i > 0; i--) {
                //     let index = (tokenLen / 8) * i;
                //     token = token.slice(0, index) + '\n' + token.slice(index)
                // }
                popUp.show('Типа залогинился')
            } else {
                popUp.show('Типа не залогинился')
                // loginButton.text = 'Failure'
                // light.color = Global.warningColor
            }
        }

        function onAuthRegisterResponse(success, value) {
            if (success) {
                popUp.show('Типа зарегался')
            } else {
                popUp.show('Типа не зарегался')
            }
        }
    }

    WPlatform {
        id: platform
        height: column.height + 80
        width: column.width + 100

        ColumnLayout {
            id: column

            anchors.centerIn: parent
            width: 200

            WText {
                Layout.alignment: Qt.AlignCenter
                Layout.bottomMargin: 15

                text: 'Allrensys'
                color: Global.strongTextColor
                sizeScale: 2
            }

            Item {
                id: nameWindow
                Layout.bottomMargin: 0
                Layout.preferredHeight: 0
                width: nameWindowColumn.width
                clip: true

                Column {
                    id: nameWindowColumn

                    WText {
                        text: 'Name'
                        font.bold: false
                        sizeScale: 0.8
                    }

                    WTextField {
                        id: name
                        width: buttonsRow.width
                        nextField: username.core
                    }
                }
            }

            Column {
                Layout.alignment: Qt.AlignCenter
                Layout.bottomMargin: 5

                WText {
                    text: 'Username'
                    font.bold: false
                    sizeScale: 0.8
                }

                WTextField {
                    id: username
                    width: buttonsRow.width
                    nextField: password.core
                }
            }

            Column {
                id: passwordWindow
                Layout.alignment: Qt.AlignCenter
                Layout.bottomMargin: 0

                WText {
                    text: 'Password'
                    font.bold: false
                    sizeScale: 0.8
                }

                WTextField {
                    id: password
                    width: buttonsRow.width
                    echoMode: TextInput.Password
                    nextField: root.expanded ? passwordAgain.core : username.core
                }
            }

            Item {
                id: passwordAgainWindow
                Layout.bottomMargin: 0
                Layout.preferredHeight: 0
                width: nameWindowColumn.width
                clip: true

                Column {
                    WText {
                        text: 'Password Again'
                        font.bold: false
                        sizeScale: 0.8
                    }

                    WTextField {
                        id: passwordAgain
                        width: buttonsRow.width
                        echoMode: TextInput.Password
                        nextField: name.core
                    }
                }
            }

            RowLayout {
                id: buttonsRow
                Layout.alignment: Qt.AlignCenter
                Layout.topMargin: 15
                spacing: 15

                WButton {
                    id: loginButton
                    Layout.alignment: Qt.AlignCenter
                    text: 'Login'
                    color: Global.successColor
                    autoSize: true

                    onClicked: {
                        registerButton.clickAnimation.complete()
                        loginButtonDiselectAnimtaion.complete()
                        loginButton.color = Global.successColor

                        if (root.expanded) {
                            registerFieldsShrinkAnimtaion.start()
                        } else {
                            api.authLogin(username.text, password.text)
                        }

                        root.expanded = false
                        registerButtonDiselectAnimtaion.start()
                    }

                    PropertyAnimation {
                        id: loginButtonDiselectAnimtaion
                        target: loginButton
                        property: 'color'
                        to: 'white'
                        duration: Global.animationDuration
                        easing.type: Easing.InOutQuad
                    }

                    ParallelAnimation {
                        id: registerFieldsShrinkAnimtaion

                        PropertyAnimation {
                            targets: [nameWindow, passwordAgainWindow]
                            property: 'Layout.preferredHeight'
                            to: 0
                            duration: Global.animationDuration
                            easing.type: Easing.InOutQuad
                        }

                        PropertyAnimation {
                            targets: [nameWindow, passwordWindow]
                            property: 'Layout.bottomMargin'
                            to: 0
                            duration: Global.animationDuration
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                WButton {
                    id: registerButton
                    Layout.alignment: Qt.AlignCenter
                    text: 'Register'
                    color: 'white'
                    autoSize: true

                    onClicked: {
                        loginButton.clickAnimation.complete()
                        registerButtonDiselectAnimtaion.complete()
                        registerButton.color = Global.successColor

                        if (!root.expanded) {
                            registerFieldsExpandAnimtaion.start()
                        } else {
                            if (password.text == passwordAgain.text) {
                                api.authRegister(name.text, username.text, password.text)
                            } else {
                                popUp.show("Типа пароли не совпали")
                            }
                        }

                        root.expanded = true
                        loginButtonDiselectAnimtaion.start()
                    }

                    PropertyAnimation {
                        id: registerButtonDiselectAnimtaion
                        target: registerButton
                        property: 'color'
                        to: 'white'
                        duration: Global.animationDuration
                        easing.type: Easing.InOutQuad
                    }

                    ParallelAnimation {
                        id: registerFieldsExpandAnimtaion

                        PropertyAnimation {
                            targets: [nameWindow, passwordAgainWindow]
                            property: 'Layout.preferredHeight'
                            to: nameWindowColumn.height
                            duration: Global.animationDuration
                            easing.type: Easing.InOutQuad
                        }

                        PropertyAnimation {
                            targets: [nameWindow, passwordWindow]
                            property: 'Layout.bottomMargin'
                            to: 5
                            duration: Global.animationDuration
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
    }

    WPopUp {
        id: popUp
        anchors.centerIn: parent
        autohide: false
        // text.font.pixelSize: 15
    }
}
