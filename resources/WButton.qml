import QtQuick
import QtQuick.Effects

Item {
    id: root
    height: 40 * Global.scale
    width: autoSize ? buttonText.width + 50 * Global.scale : 100 * Global.scale
    property bool autoSize: false
    property alias text: buttonText.text
    property color color: 'white'
    property alias clickAnimation: buttonClickAnimation
    signal clicked(var mouse)

    Component.onCompleted: {
        // buttonMA.clicked.connect(clicked)
    }

    Rectangle {
        id: buttonRect
        y: 0
        color: root.color
        width: parent.width
        height: parent.height
        radius: height / 2
        border.width: 0
        border.color: '#bbbbff'

        MouseArea {
            id: buttonMA
            hoverEnabled: true
            anchors.fill: parent
            // property bool hovered: false
            onEntered: {
                buttonRect.border.width = 1
            }
            onExited: {
                buttonRect.border.width = 0
            }
            onClicked: function(mouse) {
                root.clicked(mouse)
                buttonClickAnimation.restart()
            }
        }

        Text {
            id: buttonText
            anchors.centerIn: parent
            color: Global.strongTextColor
            font {
                pixelSize: Global.fontSize
                family: Global.fontFamily
                bold: true
            }
        }
    }

    SequentialAnimation {
        id: buttonClickAnimation

        ParallelAnimation {

            NumberAnimation {
                target: buttonShadow
                property: 'shadowBlur'
                to: 0.1
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: buttonShadow
                property: 'shadowScale'
                to: 0.95
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: buttonShadow
                property: 'shadowVerticalOffset'
                to: 0
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: buttonShadow
                property: 'shadowOpacity'
                to: 0.5
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: buttonRect
                property: 'color.r'
                to: root.color.r * 0.98
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: buttonRect
                property: 'color.g'
                to: root.color.g * 0.98
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: buttonRect
                property: 'color.b'
                to: root.color.b * 0.98
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: buttonRect
                property: 'y'
                to: 3 * Global.scale
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }
        }

        ParallelAnimation {

            NumberAnimation {
                target: buttonShadow
                property: 'shadowBlur'
                to: 0.3
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }


            NumberAnimation {
                target: buttonShadow
                property: 'shadowScale'
                to: 1
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: buttonShadow
                property: 'shadowVerticalOffset'
                to: 3 * Global.scale
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: buttonShadow
                property: 'shadowOpacity'
                to: 0.3
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: buttonRect
                property: 'color.r'
                to: root.color.r
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: buttonRect
                property: 'color.g'
                to: root.color.g
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                target: buttonRect
                property: 'color.b'
                to: root.color.b
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                target: buttonRect
                property: 'y'
                to: 0
                duration: Global.animationDuration
                easing.type: Easing.InOutQuad
            }
        }
    }

    MultiEffect {
        id: buttonShadow
        source: buttonRect
        anchors.fill: buttonRect
        shadowEnabled: true
        shadowBlur: 0.3
        shadowScale: 1
        shadowColor: 'black'
        shadowOpacity: 0.3
        shadowVerticalOffset: 3 * Global.scale
    }
}
