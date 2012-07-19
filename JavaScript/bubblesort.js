function bsort(l) {
    var tmp;
    for(x in l) {
        if(x < (l.length-1)) {
            if(l[x] > l[parseInt(x)+1]) {
                tmp = l[x];
                l[x] = l[parseInt(x)+1];
                l[parseInt(x)+1] = tmp;
                bsort(l)
            }
        }
    }
    return l
}
