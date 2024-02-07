function water(fish) {
    return fish
}

function cannery(fish) {
    return fish + ' canned'
}

cannery(water(water(water('fish')))) 