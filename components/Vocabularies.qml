import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

Item {
    property int selected_vocabulary: 0
    ColumnLayout {
        anchors.fill: parent
        ListView {
            id: vocabulariesList
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: vocubsModel
            delegate: Component {
                Rectangle {
                    width: parent.width
                    height: 48
                    RowLayout {
                        anchors.fill: parent
                        Image {
                            source: "qrc:/svg/select.svg"
                            sourceSize.width: 24
                            sourceSize.height: 24
                        }
                        Rectangle {
                            Layout.fillWidth: true
                            height: 24
                            Text {
                                anchors.centerIn: parent
                                text: title
                            }
                        }
                        Rectangle {
                            width: 48
                            height: 48
                            color: "lightblue"
                            Image {
                                anchors.centerIn: parent
                                source: "qrc:/svg/list.svg"
                                sourceSize.width: 24
                                sourceSize.height: 24
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    selected_vocabulary = index
                                    stack.push(wordsTitleContainer)
                                }
                            }
                        }

                        Image {
                            source: "qrc:///svg/edit.svg"
                            sourceSize.width: 24
                            sourceSize.height: 24
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    selected_vocabulary = index
                                    stack.push(vocabularySaveCancelContainer)
                                }
                            }
                        }
                        Image {
                            source: "qrc:///svg/delete.svg"
                            sourceSize.width: 24
                            sourceSize.height: 24
                            MouseArea {
                                anchors.fill: parent
                                onPressAndHold: {
                                    console.log("delete "+index)
                                }
                            }
                        }
                    }
                }
            }
        }
        Button {
            text: "Добавить словарь"
            onClicked: {
                selected_vocabulary = -1
                stack.push(vocabularySaveCancelContainer)
            }
        }
    }
    Component {
        id: wordsTitleContainer
        TitleContainer {
            title: vocabulariesModel.get(selected_vocabulary).title
            content: Words {}
        }
    }
    Component {
        id: vocabularySaveCancelContainer
        SaveCancelContainer {
            content: Vocabulary {
                flag: ""
                title: {
                    if (selected_vocabulary > -1)
                        vocabulariesModel.get(selected_vocabulary).title
                    else
                        ""
                }
                description: ""
            }
        }
    }
}
