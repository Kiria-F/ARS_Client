import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: root
    property bool exitPrepared: false
    width: 640
    height: 480
    visible: true
    title: qsTr('Allocated Rendering System')
    color: Global.backgroundColor

    Connections {
        target: api

        function onExitPrepared() {
            root.exitPrepared = true
            root.close()
        }
    }

    onClosing: (close) => {
        if (!root.exitPrepared) {
            close.accepted = false
            api.exitPrepare()
        }
    }

    Loader {
        id: loader
        anchors.centerIn: parent
        source: 'Login.qml'
    }

    WButton {
        text: 'test'
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: 10
        }

        onClicked: api.test()
    }
}
