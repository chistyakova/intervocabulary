#ifndef WORD_H
#define WORD_H

#include <QString>

class Word
{
public:
    explicit Word();
    QString native_;
    QString translation_;
    QString transcribtion_;
};

#endif // WORD_H
