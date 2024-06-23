import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("ARS")
    color: "#202020"

    Column {
        spacing: 20
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        ArsButton {
            id: msgButton

            anchors.horizontalCenter: parent.horizontalCenter

            text: "Send"

            Connections {
                target: api

                function onAuthLoginResponse(success, value) {
                    msgButton.text = success ? "Success" : "Failure"
                    output.text = value
                }
            }

            onClick: {
                api.authLogin("f", "fds")
            }
        }

        Text {
            id: output

            anchors.horizontalCenter: parent.horizontalCenter

            text: " "
            font {
                family: "Comfortaa"
                pixelSize: 8
                weight: 1000
            }
            color: Qt.rgba(1, 1, 1, 0.8)
        }
    }
}
