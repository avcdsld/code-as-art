operation ObservableArt() : Result {
    use qubit = Qubit();
    H(qubit);
    let isArt = M(qubit);
    Reset(qubit);
    return isArt;
}
