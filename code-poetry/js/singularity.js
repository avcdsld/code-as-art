const singularity = new Proxy({}, {
  get(target, prop, receiver) {
    return receiver;
  }
});
