#include "controller.h"

#include <math.h>

Controller::Controller(QObject *parent) : QObject(parent) {
   tile_size_ = 31337;
}


QVariantMap Controller::getNextWord() {
    Word w;
    QVariantMap map;
    map.insert("native", w.native_);
    map.insert("translation", w.translation_);
    map.insert("transcribtion", w.transcribtion_);
    return map;
}

int Controller::getTileSize() {
    return tile_size_;
}
