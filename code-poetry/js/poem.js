class Poem {
  constructor() {
    this.state = undefined
    this.trace = new WeakSet()
  }

  invoke(context = this) {
    this.trace.add(context)
  }

  reflect() {
    return this.trace.has(this) ? this.reflect() : this
  }

  transform(f) {
    this.state = f(this.state)
    return this
  }

  resolve() {
    return new Promise(() => {})
  }

  vanish() {
    return this.trace.delete(this) ? null : this
  }
}
