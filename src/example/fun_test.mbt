///|
type MyInt1 Int derive(Show)

///|
type MyInt2 Int derive(Show)

///|
fn succ(x : Int) -> Int {
  x + 1
}

test "single parm" {
  let x : MyInt1 = 0
  let f : (MyInt1) -> MyInt2 = @coerce.coerce(succ)
  inspect!(f(x), content="MyInt2(1)")
}

test "double parm" {
  let x : Int = @coerce.coerce(Int::op_add)((7 : MyInt1), (3 : MyInt1))
  inspect!(x, content="10")
  let x : Int = @coerce.coerce(Int::op_add)((7 : MyInt2), (3 : MyInt2))
  inspect!(x, content="10")
  let x : Int = @coerce.coerce(Int::op_add)((7 : MyInt1), (3 : MyInt2))
  inspect!(x, content="10")
  let x : Int = @coerce.coerce(Int::op_add)((7 : MyInt2), (3 : MyInt1))
  inspect!(x, content="10")
}
