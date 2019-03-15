#include "controller.h"

#include <math.h>

Controller::Controller(QObject *parent) : QObject(parent) {
   tile_size_ = 31337;
}

QString Controller::getNextWord() {
    QStringList words = {
        "Hello/Goodbye<br>안녕하세요<br>An-nyeong-ha-se-yo.",
        "Nice to meet you<br>반갑습니다<br>Ban-gap-sum-ni-da.",
        "Thank you<br>감사합니다<br>Kam-sa-ham-ni-da.",
        "I'm sorry<br>죄송합니다/미안합니다<br>Chway-seong-ham-ni-da/Mi-an-ham-ni-da."};
    return words.at(rand()%(words.length()-1));
}

int Controller::getTileSize() {
    return tile_size_;
}
