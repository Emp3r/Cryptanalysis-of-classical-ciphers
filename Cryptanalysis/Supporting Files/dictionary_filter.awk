{
word = $1;
maxRows = 100000;
minChars = 3;
maxChars = 15;

if ((length(word) >= minChars) && 
    (length(word) <= maxChars) && 
    (NR <= maxRows)) {
        print $1;
}

}
