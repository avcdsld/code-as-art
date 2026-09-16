fn main() {
    let _remembered = Vec::<u8>::with_capacity(1);
    let forgotten = Vec::<u8>::with_capacity(1);

    std::mem::forget(forgotten);

}
