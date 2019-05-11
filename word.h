#ifndef WORD_H
#define WORD_H

#include <QString>

class Word
{
public:
    explicit Word();
    bool is_learned;
    int counter;
    QString native_word_;
    QString foreign_word_;
};

#endif // WORD_H
