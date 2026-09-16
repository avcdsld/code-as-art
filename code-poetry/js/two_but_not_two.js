question = answer => () => question(!answer)

response = question(true)
while (typeof response === 'function') {
  response = response()
}
