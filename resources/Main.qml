import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr('Allocated Rendering System')
    color: Global.backgroundColor

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
