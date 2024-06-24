import QtQuick
import QtQuick.Effects

Item {
    id: root
    height: 40 * Global.scale
    width: 100 * Global.scale
    property alias text: wButtonText.text
    property color color: "white"
    signal clicked(var mouse)

    Component.onCompleted: {
        wButtonMA.clicked.connect(clicked)
    }

    Rectangle {
        id: wButtonRect
        y: 0
        color: root.color
        height: root.height
        width: root.width
        radius: height / 2
        border.width: 0
        border.color: "#bbbbff"

        MouseArea {
            id: wButtonMA
            hoverEnabled: true
            anchors.fill: parent
            // property bool hovered: false
            onEntered: {
                wButtonRect.border.width = 1
            }
            onExited: {
                wButtonRect.border.width = 0
            }
            onClicked: {
                wButtonClickAnimation.restart()
            }
        }

        Text {
            id: wButtonText
            property real defaultY: (parent.height - height) / 2
            y: defaultY
            anchors.horizontalCenter: parent.horizontalCenter
            color: Global.strongTextColor
            font {
                pixelSize: Global.fontSize
                family: Global.fontFamily
                bold: true
            }
        }
    }

    SequentialAnimation {
        id: wButtonClickAnimation

        ParallelAnimation {

            NumberAnimation {
                target: wButtonShadow
                property: "shadowBlur"
                to: 0.1
                duration: 200
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: wButtonShadow
                property: "shadowScale"
                to: 0.95
                duration: 200
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: wButtonShadow
                property: "shadowVerticalOffset"
                to: 0
                duration: 200
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: wButtonShadow
                property: "shadowOpacity"
                to: 0.5
                duration: 200
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: wButtonRect
                property: "color.r"
                to: root.color.r * 0.98
                duration: 200
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: wButtonRect
                property: "color.g"
                to: root.color.g * 0.98
                duration: 200
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: wButtonRect
                property: "color.b"
                to: root.color.b * 0.98
                duration: 200
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: wButtonRect
                property: "y"
                to: 3 * Global.scale
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        ParallelAnimation {

            NumberAnimation {
                target: wButtonShadow
                property: "shadowBlur"
                to: 0.3
                duration: 200
                easing.type: Easing.InOutQuad
            }


            NumberAnimation {
                target: wButtonShadow
                property: "shadowScale"
                to: 1
                duration: 200
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: wButtonShadow
                property: "shadowVerticalOffset"
                to: 3 * Global.scale
                duration: 200
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: wButtonShadow
                property: "shadowOpacity"
                to: 0.3
                duration: 200
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: wButtonRect
                property: "color.r"
                to: root.color.r
                duration: 200
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: wButtonRect
                property: "color.g"
                to: root.color.g
                duration: 200
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: wButtonRect
                property: "color.b"
                to: root.color.b
                duration: 200
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: wButtonRect
                property: "y"
                to: 0
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    }

    MultiEffect {
        id: wButtonShadow
        source: wButtonRect
        anchors.fill: wButtonRect
        shadowEnabled: true
        shadowBlur: 0.3
        shadowScale: 1
        shadowColor: 'black'
        shadowOpacity: 0.3
        shadowVerticalOffset: 3 * Global.scale
    }
}
