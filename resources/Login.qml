import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: root
    width: platform.width
    height: platform.height

    Connections {
        target: api

        function onAuthLoginResponse(success, value) {
            if (success) {
                loginButton.text = 'Success'
                light.color = Global.successColor
                let token = value
                let tokenLen = token.length;
                for (let i = 7; i > 0; i--) {
                    let index = (tokenLen / 8) * i;
                    token = token.slice(0, index) + '\n' + token.slice(index)
                }
                popUp.show(token)
            } else {
                loginButton.text = 'Failure'
                light.color = Global.warningColor
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
                    property bool selected: true
                    Layout.alignment: Qt.AlignCenter
                    text: 'Login'
                    color: Global.successColor
                    autoSize: true

                    onClicked: {
                        registerButton.clickAnimation.complete()
                        loginButtonDiselectAnimtaion.complete()
                        loginButton.color = Global.successColor

                        if (!loginButton.selected) {
                            registerFieldsShrinkAnimtaion.start()
                        }
                        loginButton.selected = true
                        registerButton.selected = false
                        registerButtonDiselectAnimtaion.start()
                        // api.authLogin(username.text, password.text)
                    }

                    PropertyAnimation {
                        id: loginButtonDiselectAnimtaion
                        target: loginButton
                        property: 'color'
                        to: 'white'
                        duration: Global.animationDuration
                        easing.type: Easing.InOutQuad
                    }

                    PropertyAnimation {
                        id: registerFieldsShrinkAnimtaion
                        targets: [nameWindow, passwordAgainWindow]
                        property: 'Layout.preferredHeight'
                        to: 0
                        duration: Global.animationDuration
                        easing.type: Easing.InOutQuad
                    }
                }

                WButton {
                    id: registerButton
                    property bool selected: false
                    Layout.alignment: Qt.AlignCenter
                    text: 'Register'
                    color: 'white'
                    autoSize: true

                    onClicked: {
                        loginButton.clickAnimation.complete()
                        registerButtonDiselectAnimtaion.complete()
                        registerButton.color = Global.successColor

                        if (!registerButton.selected) {
                            registerFieldsExpandAnimtaion.start()
                        }

                        registerButton.selected = true
                        loginButton.selected = false
                        loginButtonDiselectAnimtaion.start()
                        // api.authLogin(username.text, password.text)
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
        text.font.pixelSize: 15
    }
}
