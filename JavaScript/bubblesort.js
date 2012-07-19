function bsort(l) {
	var swap = false;
	var tmp;
	for(x in l) {
		if(x < (l.length-1)) {
			if(l[x] < l[parseInt(x)+1]) {
				swap = true;
				tmp = l[x];
				l[x] = l[parseInt(x)+1];
				l[parseInt(x)+1] = tmp
			}
		}
		if(swap) {bsort(l)}
	}
	return l
}
