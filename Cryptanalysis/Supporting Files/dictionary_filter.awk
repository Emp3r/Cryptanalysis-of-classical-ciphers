# filter dictionary text files, returns only words which fulfills stated features
# usage: $ awk -f <awk file> <input file> > <output file>

BEGIN {
    minChars = 3;
    maxChars = 15;
    maxRows = 10000;
    rowsPrinted = 0;
}
{
    word = $1;

    if ((length(word) >= minChars) && 
        (length(word) <= maxChars) && 
        (rowsPrinted < maxRows)) {
            print word;
            ++rowsPrinted;
    }
}
