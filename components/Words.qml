import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12


Item {
    property int selected_word: 0
    property string vocub_title
    property Component header: Component {
        Rectangle {
            anchors.fill: parent
            Text {
                anchors.centerIn: parent
                text: vocub_title
            }
        }
    }
    property Component body: Component {
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
                        height: fraction * 3
                        RowLayout {
                            width: parent.width
                            height: parent.height
                            Rectangle {
                                Layout.fillWidth: true
                                height: parent.height
                                Text {
                                    padding: fraction * 0.5
                                    anchors.left: parent.left
                                    text: native_word + "\n" + foreign_word
                                    font.pixelSize: fraction
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        editWord.open()
                                    }
                                }
                            }
                            Image {
                                source: "qrc:///svg/edit.svg"
                                sourceSize.width: fraction
                                sourceSize.height: fraction
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        selected_word = index
                                        editWord.open()
                                    }
                                }
                            }
                            Image {
                                source: "qrc:///svg/delete.svg"
                                sourceSize.width: fraction
                                sourceSize.height: fraction
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        aboutDialog.open()
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
                implicitWidth: parent.width
                onClicked: {
                    selected_word = -1
                    editWord.open()
                }
            }
            Dialog {
                id: editWord
                modal: true
                focus: true
                title: "Добавить слово"
                standardButtons: Dialog.Ok | Dialog.Cancel
                parent: Overlay.overlay
                width: parent.width
                ColumnLayout {
                    spacing: 20
                    anchors.fill: parent
                    TextField {
                        id: nativeWord
                        focus: true
                        placeholderText: "На родном языке"
                        Layout.fillWidth: true
                        text: selected_word<0?"":wordsModel.get(selected_word).native_word
                    }
                    TextField {
                        id: foreignWord
                        placeholderText: "На иностранном языке"
                        Layout.fillWidth: true
                        text: selected_word<0?"":wordsModel.get(selected_word).foreign_word
                    }
                }
                onAccepted: controller.saveWord(
                                vocub_title,
                                nativeWord.text,
                                foreignWord.text)
            }
        }
    }
}
