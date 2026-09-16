explore = (question) => {
    explore('!' + question)
    return eval(question)
}
explore('answer')
