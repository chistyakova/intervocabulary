import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

Item {
    property int selected_word: 0
    ColumnLayout {
        anchors.fill: parent
        ListView {
            id: wordsList
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: wordsModel
            delegate: Component {
                Rectangle {
                    width: parent.width
                    height: fraction * 2
                    RowLayout {
                        width: parent.width
                        height: parent.height
                        Rectangle {
                            Layout.fillWidth: true
                            height: parent.height
                            Text {
                                anchors.centerIn: parent
                                text: native_word+" - "+foreign_word
                            }
                        }
                        Image {
                            source: "qrc:///svg/edit.svg"
                            sourceSize.width: 24
                            sourceSize.height: 24
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    selected_word = index
                                    stack.push(wordSaveCancelContainer)
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
            text: "Добавить слово"
            font.pixelSize: fraction
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 5
            onClicked: {
                selected_word = -1
                stack.push(wordSaveCancelContainer)
            }
        }
    }
    Component {
        id: wordSaveCancelContainer
        SaveCancelContainer {
            content: Word {
                vocabulary_title: title
                native_word: {
                    if (selected_word > -1)
                        wordsModel.get(selected_word).native_word
                    else
                        ""
                }
                foreign_word: {
                    if (selected_word > -1)
                        wordsModel.get(selected_word).foreign_word
                    else
                        ""
                }
            }
        }
    }
}
