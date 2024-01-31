import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("ARS")
    color: "#202020"

    ARSButton {
        id: msgButton
        text: "Send"
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        Connections {
            target: appCore

            function onCallback(value) {
                msgButton.text = value
            }
        }

        onClick: {
            appCore.request()
        }
    }
}
