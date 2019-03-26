import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    property alias flag: flagField.text
    property alias title: titleField.text
    property alias description: descriptionFiled.text
    ColumnLayout {
        anchors.centerIn: parent
        Text {
            text: "Флаг"
        }
        TextField {
            id: flagField
        }
        Text {
            text: "Название словаря"
        }
        TextField {
            id: titleField
        }
        Text {
            text: "Описание словаря"
        }
        TextField {
            id: descriptionFiled
        }
    }
    // Здесь мы определяем фукнцию, вызываемую при клике по кнопке SAVE
    // универсального компонента SaveCancelContainer.
    Component.onCompleted: {
        parent.parent.parent.save = function() {
            controller.saveVocab(flag, title, description)
        }
    }
}
