import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Window {
    id: window
    visible: true
    width: MyGlobal.screenWidth
    height: MyGlobal.screenHeight

    Rectangle {
        width : parent.width
        height: parent.height
//        title: qsTr("Medical Demo")
/*
        header: ToolBar {
            contentHeight: toolButton.implicitHeight

            ToolButton {
                id: toolButton
                text: stackView.depth > 1 ? "\u25C0" : "\u2630"
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop()
                    } else {
                        drawer.open()
                    }
                }
            }

            Label {
                text: stackView.currentItem.title
                anchors.centerIn: parent
            }
        }
*/
        Drawer {
            id: drawer
            width: parent.width
            height: parent.height

            Column {
                anchors.fill: parent

                ItemDelegate {
                    text: qsTr("Main")
                    width: parent.width
                    onClicked: {
                        stackView.push("MainScreen.qml")
                        drawer.close()
                    }
                }
                ItemDelegate {
                    text: qsTr("Alarm")
                    width: parent.width
                    onClicked: {
                        stackView.push("AlarmScreen.qml")
                        drawer.close()
                    }
                }
            }
        }

        StackView {
            id: stackView
            initialItem: "MainScreen.qml"
            anchors.fill: parent
        }

    } //Rectangle
} //Window

