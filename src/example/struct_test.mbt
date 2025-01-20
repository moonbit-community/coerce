// Warning: Do not change the order of the fields
///|
struct MyArray[T] {
  mut buffer : UninitializedArray[T]
  mut length : Int
}

test "visit private field" {
  let xs = [1, 2, 3, 4, 5]
  let ys : MyArray[Int] = @coerce.coerce(xs)
  ys.buffer = UninitializedArray::make(10)
  for i in 0..<10 {
    ys.buffer[i] = i
  }
  ys.length = 10
  inspect!(xs, content="[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]")
}

///|
fn swap_array[A](xs : Array[A], ys : Array[A]) -> Unit {
  let xs : MyArray[A] = xs |> @coerce.coerce
  let ys : MyArray[A] = ys |> @coerce.coerce
  let temp = xs.buffer
  xs.buffer = ys.buffer
  ys.buffer = temp
  let temp = xs.length
  xs.length = ys.length
  ys.length = temp
}

test "swap_array" {
  let xs = [1, 2, 3]
  let ys = [4, 5, 6]
  swap_array(xs, ys)
  inspect!(xs, content="[4, 5, 6]")
  inspect!(ys, content="[1, 2, 3]")
}
