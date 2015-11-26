# returns only unique words from dictionary (words with unique canonical form)

BEGIN {
    maxRows = 5000;
    rowsPrinted = 0;
}
{
    word = $1;
    split(word, chars, "");    # makes array called chars with word's characters as elements

    s = 10;
    for (i = 1; i <= length(word); i++) {
        if (!(chars[i] in subs)) {
            subs[chars[i]] = s;
            ++s;
        }
    }
    canonical = "";
    for (i = 1; i <= length(word); i++) {
        canonical = canonical""subs[chars[i]];
    }
    delete subs;

    if (!(canonical in printed) && rowsPrinted < maxRows) {
        printed[canonical] = word;
        print word;
        ++rowsPrinted;
    }
}
