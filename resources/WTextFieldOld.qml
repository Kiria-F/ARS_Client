import QtQuick
import QtQuick.Controls.Basic

Item {
    id: root
    property string placeholder
    property alias text: textInput.text
    property alias font: textInput.font
    property alias cursorPosition: textInput.cursorPosition
    property bool hexFilter: false
    property bool numFilter: false
    property bool forceUpper: false
    property alias horizontalAlignment: textInput.horizontalAlignment
    property bool readonly: false
    property bool textWrap: false
    property real verticalBorderMargin: 5  // a space between top/bottom border and text
    property real horizontalBorderMargin: 8  // a space between left/right border and text
    property bool animatedLinesCount: true  // animated item resizing when lines changed

    property real lines: 0  // init visible lines count
    property int maxTotalLength: 0  // max text length
    property int maxLines: 0  // max possible increasing lines count
    property bool linesAuto: false  // true - lines react on text lines count

    property int lineWidth: 0  // max letters amount in a line
    property bool strictLineWidth: false  // true - you can't insert break line in an any part of the line
    property bool lineWidthAuto: true  // true - lineWidth react on width changes

    Component.onCompleted: {
        let buffer = animatedLinesCount
        animatedLinesCount = false
        if (height === 0) {
            lines = 1
        }
        animatedLinesCount = buffer
    }

    onLinesChanged: {
        heightAnimation.targetLines = lines
        heightAnimation.restart()
        heightAnimation.complete()
    }

    onWidthChanged: {
        if (lineWidthAuto) {
            lineWidth = (width - 20) / 12
        }
    }

    onHexFilterChanged: textInput.process()
    onNumFilterChanged: textInput.process()
    onStrictLineWidthChanged: textInput.process()
    onMaxTotalLengthChanged: textInput.process()

    // transitions: [
    //     Transition {
    //         PropertyAnimation {
    //             properties: 'height'
    //             duration: 400
    //             easing.type: Easing.InOutQuad
    //         }
    //     }
    // ]

    PropertyAnimation {
        id: heightAnimation
        property real targetLines
        target: root
        property: "height"
        to: targetLines * letter.height + root.verticalBorderMargin * 2
        duration: 400
        easing.type: Easing.InOutQuad
    }

    Rectangle {
        id: border

        anchors.fill: root
        radius: Global.smallRadius
        border {
            width: 2 * Global.scale
            color: root.readonly ? Global.weakTextColor : Global.strongTextColor
        }
        clip: true

        TextInput {
            id: textInput
            readOnly: root.readonly
            anchors {
                fill: parent
                topMargin: root.verticalBorderMargin
                bottomMargin: root.verticalBorderMargin
                leftMargin: root.horizontalBorderMargin
                rightMargin: root.horizontalBorderMargin
            }
            color: Global.strongTextColor
            font {
                family: Global.fontFamily
                bold: true
                pixelSize: Global.fontSize
            }
            selectionColor: Global.strongTextColor

            function setTextWidth(textIn: string, lineWidth: int, strictLineWidth: bool): string {
                let lineIndex = 0
                for (let i = 0; i < textIn.length; ++i) {
                    if (textIn[i] === '\n') {
                        if (lineIndex === lineWidth && i !== textIn.length - 1) {
                            lineIndex = 0
                            continue
                        }
                        if (strictLineWidth) {
                            textIn = textIn.slice(0, i) + textIn.slice(i + 1)
                            --i
                        } else {
                            lineIndex = 0
                        }
                        continue
                    }
                    if (lineIndex === lineWidth) {
                        textIn = textIn.slice(0, i) + '\n' + textIn.slice(i)
                        ++i
                        lineIndex = 0
                        continue
                    }
                    ++lineIndex
                }
                return textIn
            }

            function filter(textIn: string, rule: string) {
                rule += '\n'
                for (let i = 0; i < textIn.length; ++i) {
                    if (rule.indexOf(textIn[i]) === -1) {
                        textIn = textIn.slice(0, i) + textIn.slice(i + 1)
                        --i
                    }
                }
                return textIn
            }

            function limitTotalLength(textIn: string): string {
                let maxLen = root.maxTotalLength
                if (strictLineWidth) {
                    maxLen += root.lines - 1
                }
                return textIn.substring(0, maxLen)
            }

            function process() {
                let pos = cursorPosition
                let textLocal = text
                let rawTextLen = textLocal.length;
                if (root.forceUpper) textLocal = textLocal.toUpperCase()
                if (root.hexFilter) textLocal = filter(textLocal, '0123456789abcdefABCDEF')
                if (root.numFilter) textLocal = filter(textLocal, '0123456789')
                if (root.textWrap) {
                    textLocal = setTextWidth(textLocal, root.lineWidth, root.strictLineWidth)
                }
                if (root.linesAuto) {
                    root.lines = textLocal.split('\n').length
                    root.lines = Math.min(root.maxLines, root.lines)
                }
                if (root.maxTotalLength > 0) textLocal = limitTotalLength(textLocal)
                else {
                    let splittedText = textLocal.split('\n')
                    textLocal = splittedText[0]
                    for (let i = 1; i < Math.min(root.lines, splittedText.length); ++i) {
                        textLocal += '\n' + splittedText[i]
                    }
                }
                if (text !== textLocal) {
                    text = textLocal
                    cursorPosition = pos - (rawTextLen - text.length)
                }
            }

            onTextChanged: process()

            PlaceholderText {
                id: placeholder
                anchors.centerIn: parent
                text: textInput.text.length === 0 ? root.placeholder : ""
                color: Global.weakTextColor
                font {
                    family: Global.fontFamily
                    bold: true
                    pixelSize: Global.fontSize
                }
            }
        }
    }

    Text {
        id: letter
        visible: false
        font: root.font
        text: 'X'
    }
}
