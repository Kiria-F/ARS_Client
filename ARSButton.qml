import QtQuick
import QtQuick.Controls

Rectangle {
    id: xButton
    property string text: ""
    property color fontColor: Qt.rgba(1, 1, 1, 0.8)
    height: 40
    width: 200
    border.width: 1
    border.color: Qt.rgba(0.4, 0.7, 0.8, 0.8)
    radius: 25
    color: "transparent"
    signal click(QtObject event)

    states: [
        State {
            name: "enabled"
            PropertyChanges {
                target: xButton
                color: "transparent"
                fontColor: Qt.rgba(1, 1, 1, 0.8)
                border.color: Qt.rgba(0.4, 0.7, 0.8, 0.8)
            }
        },
        State {
            name: "disabled"
            PropertyChanges {
                target: xButton
                color: Qt.rgba(1, 1, 1, 0.2)
                fontColor: Qt.rgba(1, 1, 1, 0.4)
                border.color: Qt.rgba(0.6, 0.6, 0.6, 0.8)
            }
        },
        State {
            name: "hovered"
            PropertyChanges {
                target: xButton
                color: Qt.rgba(0.4, 0.7, 0.8, 0.8)
            }
        },
        State {
            name: "pressed"
            PropertyChanges {
                target: xButton
                color: Qt.rgba(0.4, 0.7, 0.8, 0.4)
            }
        }
    ]

    transitions: [
        Transition {
            from: "*"
            to: "*"
            PropertyAnimation {
                target: xButton
                property: "color"
                duration: 80
            }
        }
    ]

    Text {
        text: parent.text
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        font {
            family: "Comfortaa"
            pixelSize: 20
            weight: 1000
        }
        color: parent.fontColor
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onExited: {
            if (xButton.state !== "disabled") {
                xButton.state = "none"
            }
        }
        onEntered: {
            if (xButton.state !== "disabled") {
                xButton.state = "hovered"
            }
        }
        onPressed: {
            if (xButton.state !== "disabled") {
                xButton.state = "pressed"
            }
        }
        onReleased: {
            if (xButton.state !== "disabled") {
                xButton.state = "hovered"
            }
        }
        onClicked: (event) => {
            if (xButton.state !== "disabled") {
                xButton.click(event)
            }
        }
    }
}

