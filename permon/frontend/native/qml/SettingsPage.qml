import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

Page {
    signal cancelButtonClicked
    signal acceptButtonClicked
    id: settingsPage

    header: ToolBar {
        height: 50

        Rectangle {
            id: headerRectangle
            anchors.fill: parent
            color: "#333"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 3
                anchors.rightMargin: 3
                spacing: 5

                Label {
                    font.pixelSize: 26
                    font.bold: true
                    color: "white"
                    text: "permon"
                }

                Label {
                    font.pixelSize: 26
                    color: "white"
                    text: "Settings"
                }

                Item {
                    Layout.fillWidth: true
                }
            }
        }

        DropShadow {
            source: headerRectangle
            anchors.fill: source
            color: "black"
            radius: 10.0
            samples: radius * 2
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        RowLayout {
            Layout.topMargin: 10
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Layout.preferredWidth: parent.width
            spacing: 50


            ColumnLayout {
                Layout.preferredWidth: parent.Layout.preferredWidth / 2
                Label {
                    text: "Displayed Stats"
                    font.pixelSize: 26
                }

                ListView {
                    id: listView
                    model: settingsModel
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    // delegate: ColumnLayout {
                    //     id: stat
                    //     Layout.fillWidth: true

                    //     Label {
                    //         Layout.leftMargin: 10
                    //         visible: model.isFirstInCategory
                    //         verticalAlignment: Text.AlignVCenter
                    //         text: model.rootTag
                    //         font.pixelSize: 22
                    //     }

                    //     RowLayout {
                    //         Layout.fillWidth: true
                    //         visible: model.checked

                    //         Label {
                    //             Layout.leftMargin: 20
                    //             font.pixelSize: 18
                    //             font.family: "Roboto Mono"
                    //             text: model.name
                    //         }

                    //         Item {
                    //             Layout.fillWidth: true
                    //         }

                    //         Label {
                    //             text: "test"
                    //         }
                    //     }
                    // }
                    delegate: Column {
                        width: parent.width
                        Label {
                            Layout.leftMargin: 10
                            visible: model.isFirstInCategory
                            verticalAlignment: Text.AlignVCenter
                            text: model.rootTag
                            font.pixelSize: 22
                        }

                        RowLayout {
                            visible: model.checked
                            width: parent.width
                            Label {
                                Layout.leftMargin: 20
                                font.pixelSize: 18
                                font.family: "Roboto Mono"
                                text: model.name
                            }

                            Label {
                                color: "#ed5565"
                                Layout.alignment: Qt.AlignRight
                                text: "X"
                                font.pixelSize: 18
                                font.bold: true

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        model.checked = false;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            ColumnLayout {
                Layout.preferredWidth: parent.Layout.preferredWidth / 2
                Layout.alignment: Qt.AlignTop

                Label {
                    text: "Add a Stat"
                    font.pixelSize: 26
                }

                ComboBox {
                    id: statBox
                    Layout.fillWidth: true
                    textRole: "name"
                    model: settingsModel
                }

                Button {
                    Layout.alignment: Qt.AlignRight

                    text: "<font color='white'>Add</font>"
                    font.pixelSize: 20
                    font.bold: true
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 50
                        color: "#48cfad"
                    }

                    DropShadow {
                        anchors.fill: source
                        color: "#777"
                        radius: 10.0
                        samples: radius * 2
                        source: parent.background
                        horizontalOffset: 3
                        verticalOffset: 3
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            var index = settingsModel.index(statBox.currentIndex, 0);
                            settingsModel.setData(index, true, Qt.UserRole + 2 /* Checked Role */)
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }

    footer: RowLayout {
        Button {
            Layout.bottomMargin: 20
            Layout.leftMargin: 20
            text: "Cancel"
            font.pixelSize: 20
            font.bold: true
            background: Rectangle {
                id: cancelButtonBackground
                implicitWidth: 100
                implicitHeight: 50
            }

            DropShadow {
                anchors.fill: cancelButtonBackground
                color: "#777"
                radius: 10.0
                samples: radius * 2
                source: cancelButtonBackground
                horizontalOffset: 3
                verticalOffset: 3
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    settingsModel.resetSettings();
                    settingsPage.cancelButtonClicked();
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }

        Button {
            Layout.bottomMargin: 20
            Layout.rightMargin: 20
            text: "<font color='white'>Accept</font>"
            font.pixelSize: 20
            font.bold: true
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 50
                color: "#48cfad"
            }

            DropShadow {
                anchors.fill: source
                color: "#777"
                radius: 10.0
                samples: radius * 2
                source: parent.background
                horizontalOffset: 3
                verticalOffset: 3
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    settingsModel.submitSettings();
                    settingsPage.acceptButtonClicked();
                }
            }
        }
    }
}