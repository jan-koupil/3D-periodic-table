function exists( i) {
    if ((i < 0) || (i > 161)) return false;
    if (i > 0 && i < 17) return false;
    if (i > 19 && i < 30) return false;
    if (i > 37 && i < 48) return false;
    if (i > 125 && i < 128) return false;
    if (i > 142 && i < 146) return false;
    return true;
}

let arr = [];
for (let i = 0; i < 161; i++){
    arr[i] = exists(i);
}

console.log("[" + arr.join(",") + "]");
