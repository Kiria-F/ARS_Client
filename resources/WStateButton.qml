import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

Item {
    id: root
    property alias text: wButtonText.text
    property color color: "white"
    property list<var> group
    property bool disabledCondition
    property bool pressed: state === 'pressed'
    property bool disabled: false
    height: 40
    width: 100

    signal clicked(var mouse)
    signal released

    function release() {
        if (state === "pressed") {
            root.state = ""
            root.released()
        }
    }

    function disbale() {
        root.state = "disabled"
    }

    function enable() {
        root.state = ""
    }

    Component.onCompleted: {
        wButtonMA.clicked.connect(clicked)
    }

    Rectangle {
        id: wButtonRect
        y: 0
        color: root.color
        height: root.height
        width: root.width
        radius: Global.radius
        border {
            width: 1
            color: "#01bbbbff"
        }

        MouseArea {
            id: wButtonMA
            hoverEnabled: true
            anchors.fill: parent
            onClicked: {
                if (!root.pressed && !root.disabled) {
                    root.state = "pressed"
                    for (var i = 0; i < root.group.length; ++i) {
                        if (group[i] !== root) {
                            root.group[i].release()
                        }
                    }
                }
            }
        }

        Text {
            id: wButtonText
            property real defaultY: (parent.height - height) / 2
            y: defaultY
            anchors.horizontalCenter: parent.horizontalCenter
            color: Global.weakTextColor
            font {
                pixelSize: Global.fontSize
                family: Global.fontFamily
                bold: true
            }
        }

        Shape {
            id: dashedBorder
            opacity: 0
            anchors.fill: parent

            ShapePath {
                id: db
                strokeColor: Global.phantomTextColor
                strokeWidth: 2
                strokeStyle: ShapePath.DashLine
                fillColor: "transparent"
                property real w: dashedBorder.width
                property real h: dashedBorder.height
                property real r: Global.radius

                startX: r
                startY: h
                PathArc { relativeX: 0; y: 0; radiusX: db.r; radiusY: db.r }
                PathLine { x: db.w - db.r; relativeY: 0 }
                PathArc { relativeX: 0; y: db.h; radiusX: db.r; radiusY: db.r }
                PathLine { x: db.r; relativeY: 0 }
            }
        }

        Shape {
            id: thickBorder
            opacity: 0
            anchors.fill: parent

            ShapePath {
                id: tb
                strokeColor: Global.weakTextColor
                strokeWidth: 0
                fillColor: "transparent"
                property real w: dashedBorder.width
                property real h: dashedBorder.height
                property real r: Global.radius

                startX: r
                startY: h
                PathArc { relativeX: 0; y: 0; radiusX: tb.r; radiusY: tb.r }
                PathLine { x: tb.w - tb.r; relativeY: 0 }
                PathArc { relativeX: 0; y: tb.h; radiusX: tb.r; radiusY: tb.r }
                PathLine { x: tb.r; relativeY: 0 }
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
        shadowVerticalOffset: 3
    }

    transitions: [
        Transition {
            from: "pressed, disabled"
            PropertyAnimation {
                properties: "color, color.r, color.g, color.b, shadowBlur, shadowScale, shadowVerticalOffset, shadowOpacity, strokeWidth, y, opacity"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        },

        Transition {
            to: "pressed, disabled"
            PropertyAnimation {
                properties: "color, color.r, color.g, color.b, shadowBlur, shadowScale, shadowVerticalOffset, shadowOpacity, strokeWidth, y, opacity"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    ]

    states: [
        State {
            name: ""
            PropertyChanges { target: wButtonRect; border.color: "#01bbbbff"}
        },

        State {
            name: "hovered"
            when: wButtonMA.containsMouse && !root.pressed && !root.disabled
            PropertyChanges { target: wButtonRect; border.color: "#ffbbbbff"}
        },

        State {
            name: "pressed"
            // PropertyChanges { target: wButton; pressed: true }
            PropertyChanges { target: wButtonText; color: Global.strongTextColor }
            PropertyChanges { target: wButtonRect; color.r: root.color.r * 0.98 }
            PropertyChanges { target: wButtonRect; color.g: root.color.g * 0.98 }
            PropertyChanges { target: wButtonRect; color.b: root.color.b * 0.98 }
            PropertyChanges { target: wButtonRect; y: 3 }
            PropertyChanges { target: wButtonShadow; shadowBlur: 0.1 }
            PropertyChanges { target: wButtonShadow; shadowScale: 0.95 }
            PropertyChanges { target: wButtonShadow; shadowVerticalOffset: 0 }
            PropertyChanges { target: wButtonShadow; shadowOpacity: 0.5 }
            PropertyChanges { target: thickBorder; opacity: 1 }
            PropertyChanges { target: tb; strokeWidth: 2 }
            PropertyChanges { target: wButtonMA; hoverEnabled: false }
        },

        State {
            name: "disabled"
            when: root.disabledCondition
            PropertyChanges { target: root; disabled: true }
            PropertyChanges { target: wButtonText; color: Global.phantomTextColor }
            PropertyChanges { target: wButtonRect; y: 0 }
            PropertyChanges { target: wButtonShadow; shadowBlur: 0 }
            PropertyChanges { target: wButtonShadow; shadowScale: 0.95 }
            PropertyChanges { target: wButtonShadow; shadowVerticalOffset: 0 }
            PropertyChanges { target: wButtonShadow; shadowOpacity: 0 }
            PropertyChanges { target: dashedBorder; opacity: 1 }
            PropertyChanges { target: wButtonMA; hoverEnabled: false }
        }
    ]
}
