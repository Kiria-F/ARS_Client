import QtQuick

Item {
    id: root
    height: textInput.height
    property alias core: textInput
    property alias readonly: textInput.readOnly
    property alias text: textInput.text
    property alias passwordCharacter: textInput.passwordCharacter
    property alias echoMode: textInput.echoMode
    property var nextField

    Rectangle {
        id: border
        anchors.fill: parent
        color: 'transparent'
        radius: Global.smallRadius
        border {
            width: 2 * Global.scale
            color: root.readonly ? Global.weakTextColor : Global.strongTextColor
        }
        clip: true

        TextInput {
            id: textInput
            width: parent.width
            color: Global.strongTextColor
            font {
                family: Global.fontFamily
                bold: true
                pixelSize: Global.fontSize
            }
            selectionColor: Global.strongTextColor
            containmentMask: border
            topPadding: 5
            bottomPadding: topPadding
            leftPadding: 8
            rightPadding: leftPadding

            KeyNavigation.tab: root.nextField
            activeFocusOnTab: true
            Keys.onReturnPressed: KeyNavigation.tab.forceActiveFocus();

            HoverHandler {
                cursorShape: Qt.IBeamCursor
            }
        }
    }
}
